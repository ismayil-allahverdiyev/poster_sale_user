import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/settings/settings_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class SettingsBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingsController>(SettingsController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
