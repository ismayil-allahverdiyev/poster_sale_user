import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/basket_overview/basket_overview_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class BasketOverviewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<BasketOverviewController>(BasketOverviewController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
