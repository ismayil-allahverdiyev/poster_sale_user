import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/bindings/bottom_navbar/bottom_navbar_bindings.dart';
import 'package:poster_sale_user/src/bindings/login/login_bindings.dart';
import 'package:poster_sale_user/src/ui/bottom_navbar/bottom_navbar.dart';
import 'package:poster_sale_user/src/ui/login/sign_up_overview_page.dart';
import '../../constants/local_storage.dart';
import '../../data/repository/repository.dart';
import '../../routes/app_routes.dart';
import '../local_storage/local_storage_controller.dart';

class AppController extends GetxController {
  final Repository repository;
  AppController({required this.repository});

  Route generateRouteControlFunction(RouteSettings route) {
    var localStorageController = Get.find<LocalStorageController>();
    var startPage =
        localStorageController.getStringFromLocal(LocalStorageConst.startPage);

    localStorageController.saveBooleanToLocal(LocalStorageConst.login, true);
    if (startPage == Routes.SIGNUPOVERVIEW || startPage == "") {
      return GetPageRoute(
        settings: route,
        page: () => const SignUpOverviewPage(),
        binding: LoginBinding(),
      );
    }
    return GetPageRoute(
      settings: route,
      page: () => BottomNavBar(),
      binding: BottomNavBarBinding(),
    );
  }
}
