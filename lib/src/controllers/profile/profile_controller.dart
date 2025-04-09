import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/user/user_model.dart';
import '../../data/models/poster/poster_model.dart';
import '../../data/repository/repository.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  ProfileController({required this.repository});

  // Variables
  var user = Rxn<UserModel>();
  var isLoaded = false.obs;

  // ***********************************************

  // initalization
  @override
  onInit() async {
    super.onInit();
    await getUserInfo();
  }

  // ***********************************************

  getUserInfo() async {
    var customerId = repository.getUserId();
    if (customerId == null) {
      repository.errorHandler(
        title: "Something went wrong!",
        message: "Could not retrieve user info.",
      );
      return;
    }
    isLoaded.value = false;
    var res = await repository.getData(
      collection: "users",
      searchCriteria: {
        "id": customerId,
      },
    );

    if (res.isEmpty) {
      repository.errorHandler(
        title: "Error",
        message: "We could not get your user information!",
      );
    } else {
      user.value = UserModel.fromJson(res[0]);
    }

    isLoaded.value = true;
  }
}
