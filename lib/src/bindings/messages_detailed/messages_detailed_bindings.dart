import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../controllers/messages_detailed/messages_detailed_controller.dart';
import '../../data/repository/repository.dart';

class MessagesDetailedBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<MessagesDetailedController>(MessagesDetailedController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
