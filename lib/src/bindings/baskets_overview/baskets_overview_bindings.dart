import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/baskets_overview/baskets_overview_controller.dart';
import '../../data/repository/repository.dart';

class BasketsOverviewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<BasketsOverviewController>(BasketsOverviewController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
