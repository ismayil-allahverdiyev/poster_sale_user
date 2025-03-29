import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/controllers/local_storage/local_storage_controller.dart';
import 'src/data/repository/repository.dart';
import 'src/data/utils/default_options.dart';
import 'src/data/utils/firebase_api.dart';
import 'src/routes/app_pages.dart';
import 'src/routes/app_routes.dart';
import 'src/ui/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseApi().initPlatformState();

  SharedPreferences.getInstance().then((instance) {
    Get.put(LocalStorageController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
    Get.find<LocalStorageController>().localStorage = instance;
    runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INITIAL,
      theme: appThemeData,
      defaultTransition: Transition.rightToLeft,
      getPages: AppPages.pages,
    ));
  });
}
