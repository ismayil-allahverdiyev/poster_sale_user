import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/home/home_controller.dart';
import '../../data/repository/repository.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        repository: Repository(firestore: FirebaseFirestore.instance),
      ),
    );
  }
}
