import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/bottom_navbar/bottom_navbar_controller.dart';
import '../../controllers/home/home_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class BottomNavBarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<BottomNavBarController>(BottomNavBarController(
        repository: Repository(firestore: FirebaseFirestore.instance)));

    Get.put<HomeController>(HomeController(
        repository: Repository(firestore: FirebaseFirestore.instance)));

    // Get.lazyPut<MyDrawerController>(() =>
    //     MyDrawerController(repository: Repository(apiClient: ApiClient())));
  }
}
