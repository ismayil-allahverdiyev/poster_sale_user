import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/profile/profile_controller.dart';
import '../../data/repository/repository.dart';

class ProfileBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(ProfileController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
