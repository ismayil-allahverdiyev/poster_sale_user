import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/local_storage.dart';
import '../controllers/app/app_controller.dart';
import '../controllers/local_storage/local_storage_controller.dart';
import '../routes/app_routes.dart';

class AppPage extends GetView<AppController> {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    LocalStorageController localStorageController = Get.find();
    localStorageController.saveBooleanToLocal(LocalStorageConst.login, true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Navigator(
        initialRoute: Routes.SIGNUPOVERVIEW, //change it to login page
        onGenerateRoute: controller.generateRouteControlFunction,
      ),
    );
  }
}
