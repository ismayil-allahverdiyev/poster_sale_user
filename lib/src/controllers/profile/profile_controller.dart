import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/poster/poster_model.dart';
import '../../data/repository/repository.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final Repository repository;
  ProfileController({required this.repository});

  // Variables
  var myPosters = <PosterModel>[].obs;
  var isLoaded = false.obs;

  // ***********************************************

  // initalization
  @override
  onInit() async {
    super.onInit();
    await getPosters();
  }

  // ***********************************************

  getPosters() async {
    isLoaded.value = false;
    var res = await repository.getData(
      collection: "products",
      orderField: "created_at",
      isOrderDescendant: true,
    );

    myPosters.clear();

    myPosters.value = res.map((e) => PosterModel.fromJson(e)).toList();

    myPosters.refresh();

    isLoaded.value = true;
  }
}
