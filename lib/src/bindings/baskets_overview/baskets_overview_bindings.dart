import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/baskets_overview/baskets_overview_controller.dart';
import '../../controllers/bottom_navbar/bottom_navbar_controller.dart';
import '../../controllers/home/home_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class BasketsOverviewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<BasketsOverviewController>(BasketsOverviewController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
