import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/poster/poster_model.dart';
import '../../data/repository/repository.dart';

class ProductController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  ProductController({required this.repository});

  // Controller Variables
  TabController? tabController;
  TextEditingController messageController = TextEditingController();
  // ***********************************************

  // Variables
  var selectedIndex = 0.obs;
  String id = Get.parameters['id']!;

  var isLoaded = false.obs;

  var poster = Rxn<PosterModel>();
  // ***********************************************

  // initalization
  @override
  onInit() async {
    super.onInit();

    await getPoster();
  }
  // ***********************************************

  // Functions
  getPoster() async {
    isLoaded.value = false;
    try {
      var response =
          await repository.getData(collection: "products", documentId: id);

      if (response.isEmpty) {
        repository.errorHandler(
          title: "Could not get poster",
          message: "Poster not found",
        );
      } else {
        poster.value = PosterModel.fromJson(response[0]);

        tabController =
            TabController(length: poster.value!.images.length, vsync: this);
        tabController!.addListener(() {
          selectedIndex.value = tabController!.index;
        });
      }

      isLoaded.value = true;
    } catch (e) {
      repository.errorHandler(
        title: "Could not get poster",
        message: e.toString(),
      );
    }
  }
}
