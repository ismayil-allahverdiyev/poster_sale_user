import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/basket_overview/basket_overview_controller.dart';
import 'package:poster_sale_user/src/controllers/home/home_controller.dart';
import 'package:poster_sale_user/src/controllers/message_overview/message_overview_controller.dart';
import 'package:poster_sale_user/src/controllers/profile/profile_controller.dart';
import 'package:poster_sale_user/src/ui/baskets_overview/baskets_overview_page.dart';
import 'package:poster_sale_user/src/ui/home/home_page.dart';
import 'package:poster_sale_user/src/ui/message_overview/message_overview_page.dart';
import 'package:poster_sale_user/src/ui/profile/profile_page.dart';
import '../../data/repository/repository.dart';

class BottomNavBarController extends GetxController {
  final Repository repository;
  BottomNavBarController({required this.repository});

  var currentIndex = 0.obs;
  var lastTappedIndex = 0.obs;

  final pages = <Widget>[
    const HomePage(),
    const MessageOverviewPage(),
    const BasketsOverviewPage(),
    const ProfilePage(),
  ];

  changePage(int index) async {
    currentIndex.value = index;
    lastTappedIndex.value = currentIndex.value;
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

  onTap(index) {
    if (index == 4) {
      repository.signOut();
    } else if (index != currentIndex.value) {
      changePage(index);
      disposeController();
      initializeController();
    }
  }
}
