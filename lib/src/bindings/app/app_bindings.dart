import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/app/app_controller.dart';
import '../../data/repository/repository.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppController>(
      () => AppController(
        repository: Repository(firestore: FirebaseFirestore.instance),
      ),
    );
  }
}
