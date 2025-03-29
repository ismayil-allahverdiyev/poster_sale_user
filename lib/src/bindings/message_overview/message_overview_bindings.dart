import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/message_overview/message_overview_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class MessageOverviewBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MessageOverviewController>(MessageOverviewController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
