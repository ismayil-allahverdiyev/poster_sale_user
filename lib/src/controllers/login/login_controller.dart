import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/repository/repository.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  LoginController({required this.repository});

  @override
  onInit() {
    super.onInit();
    tabController = TabController(length: tabLength, vsync: this);

    tabController!.addListener(() {
      selectedIndex.value = tabController!.index;
    });
  }

  // Controllers

  var tabLength = 2;
  TabController? tabController;
  var selectedIndex = 0.obs;
  var isPasswordOn = false.obs;
  var isSignPasswordOn = false.obs;

  // ***********************************************
}
