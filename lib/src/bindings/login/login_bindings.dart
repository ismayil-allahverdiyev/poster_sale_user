import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/login/login_controller.dart';
import '../../data/repository/repository.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
