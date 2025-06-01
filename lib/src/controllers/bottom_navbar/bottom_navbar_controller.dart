import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/constants/local_storage.dart';
import 'package:poster_sale_user/src/controllers/basket_overview/basket_overview_controller.dart';
import 'package:poster_sale_user/src/controllers/home/home_controller.dart';
import 'package:poster_sale_user/src/controllers/local_storage/local_storage_controller.dart';
import 'package:poster_sale_user/src/controllers/message_overview/message_overview_controller.dart';
import 'package:poster_sale_user/src/controllers/profile/profile_controller.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_model.dart';
import 'package:poster_sale_user/src/ui/home/home_page.dart';
import 'package:poster_sale_user/src/ui/message_overview/message_overview_page.dart';
import 'package:poster_sale_user/src/ui/profile/profile_page.dart';
import '../../data/repository/repository.dart';
import '../../ui/basket_overview/basket_overview_page.dart';

class BottomNavBarController extends GetxController {
  final Repository repository;
  BottomNavBarController({required this.repository});

  // Variables
  String? userId;
  var currentIndex = 0.obs;
  var lastTappedIndex = 0.obs;

  final pages = <Widget>[
    const HomePage(),
    const MessageOverviewPage(),
    const BasketOverviewPage(),
    const ProfilePage(),
  ];

  // ***********************************************

  // initalization
  @override
  void onInit() async {
    super.onInit();
    getUserId();
    await getBasketInfo();
  }

  initializeController() {
    switch (currentIndex.value) {
      case 0:
        Get.put(
          HomeController(repository: repository),
        );
        break;
      case 1:
        Get.put(
          MessageOverviewController(
            repository: repository,
          ),
        );
      case 2:
        Get.put(
          BasketOverviewController(
            repository: repository,
          ),
        );
        break;
      case 3:
        Get.put(
          ProfileController(
            repository: repository,
          ),
        );
        break;
    }
  }

  // ***********************************************

  // Functions
  changePage(int index) async {
    currentIndex.value = index;
    lastTappedIndex.value = currentIndex.value;
  }

  // ***********************************************

  // Dispose
  disposeController() async {
    switch (currentIndex.value) {
      case 0:
        Get.delete<HomeController>();
        break;
      case 1:
        Get.delete<MessageOverviewController>();
        break;
      case 2:
        Get.delete<BasketOverviewController>();
        break;
      case 3:
        Get.delete<ProfileController>();
        break;
    }
  }

  // ***********************************************

  // Functions
  onTap(index) {
    if (index == 4) {
      repository.signOut();
    } else if (index != currentIndex.value) {
      changePage(index);
      disposeController();
      initializeController();
    }
  }

  getBasketInfo() async {
    try {
      if (!checkNullability()) return;

      var userBaskets = (await repository.getData(
        collection: "baskets",
        searchCriteria: {
          "userId": userId!,
        },
      ))
          .map((e) => BasketModel.fromJson(e))
          .toList();

      if (userBaskets.isEmpty ||
          userBaskets.where((e) => e.state == BasketState.active).isEmpty) {
        await createBasket();
      } else {
        var localStorageController = Get.find<LocalStorageController>();
        localStorageController.saveStringToLocal(
          LocalStorageConst.basketId,
          userBaskets
              .firstWhere((e) => e.state == BasketState.active)
              .id
              .toString(),
        );
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not get basket information",
        message: e.toString(),
      );
    }
  }

  createBasket() async {
    try {
      if (!checkNullability()) return;

      var res = await repository.postData(
        collection: "baskets",
        data: BasketModel(
          id: "",
          updated_at: Timestamp.now(),
          state: BasketState.active,
          userId: repository.getUserId()!,
        ).toAddJson(),
      );

      if (res == null) {
        repository.errorHandler(
          title: "Could not create basket",
          message: "Please try again later.",
        );
      } else {
        var localStorageController = Get.find<LocalStorageController>();
        localStorageController.saveStringToLocal(
            LocalStorageConst.basketId, res);
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not create basket",
        message: e.toString(),
      );
    }
  }

  getUserId() {
    userId = repository.getUserId();
  }

  checkNullability() {
    if (userId == null) {
      repository.errorHandler(
        title: "Something went wrong!",
        message: "Could not get user information.",
      );
      return false;
    }

    return true;
  }

  // ***********************************************
}
