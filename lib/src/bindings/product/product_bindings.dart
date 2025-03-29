import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/product/product_controller.dart';
import '../../data/provider/api_client.dart';
import '../../data/repository/repository.dart';

class ProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ProductController>(ProductController(
        repository: Repository(firestore: FirebaseFirestore.instance)));
  }
}
