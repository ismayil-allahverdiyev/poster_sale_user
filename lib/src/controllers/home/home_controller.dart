import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/categories/category_model.dart';
import 'package:poster_sale_user/src/data/models/poster/poster_model.dart';
import '../../data/repository/repository.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  final Repository repository;
  HomeController({required this.repository});

  @override
  void onInit() async {
    super.onInit();

    await getPosters();

    searchFocusNode.addListener(() async {
      isFocused.value = searchFocusNode.hasFocus;
      if (searchFocusNode.hasFocus) {
        isSearchIsOn.value = true;
        await searchPosters();
      }
    });

    await getCategories();
  }

  // Controllers and variables
  TabController? tabController;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = TextEditingController();
  Timer? timer;
  var isFocused = false.obs;
  var isSearchIsOn = false.obs;

  var selectedCategories = [].obs;
  var allPosters = <PosterModel>[].obs;
  var foundPosters = <PosterModel>[].obs;

  var categories = <CategoryModel>[].obs;

  // ****************************************************

  // init functions

  getCategories() async {
    try {
      var res = await repository.getData(collection: "categories");

      categories.value = res.map((e) => CategoryModel.fromJson(e)).toList();

      categories.refresh();
    } catch (e) {
      repository.errorHandler(
        title: "Could not get categories",
        message: e.toString(),
      );
    }
  }

  setTabController(int tabLength) {
    tabController = TabController(length: tabLength, vsync: this);
    setAutoScroll();
  }

  // ****************************************************

  // Functions
  void animate({required bool isRight}) {
    try {
      if (isRight) {
        if (tabController!.index != tabController!.length - 1) {
          tabController!.animateTo(tabController!.index + 1);
        } else {
          tabController!.animateTo(0);
        }
      } else {
        if (tabController!.index != 0) {
          tabController!.animateTo(tabController!.index - 1);
        } else {
          tabController!.animateTo(tabController!.length - 1);
        }
      }
    } catch (e) {
      repository.errorHandler(
        title: "Could not animate",
        message: e.toString(),
      );
    }
  }

  void setAutoScroll() {
    timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        animate(isRight: true);
      },
    );
  }

  onCategorySelected(int? index) async {
    if (!searchFocusNode.hasFocus) {
      selectedCategories.clear();
      searchFocusNode.requestFocus();
    }
    if (index == null) {
      searchController.clear();
      await searchPosters();
      return;
    }

    if (selectedCategories.contains(categories[index].id)) {
      selectedCategories.remove(categories[index].id);
    } else {
      selectedCategories.add(categories[index].id);
    }

    await searchPosters();
  }

  clearSearch() {
    searchFocusNode.unfocus();
    isSearchIsOn.value = false;
    selectedCategories.clear();
  }

  getPosters() async {
    try {
      var res = await repository.getData(
        collection: "products",
        orderField: "created_at",
        isOrderDescendant: true,
      );

      allPosters.value = res.map((e) => PosterModel.fromJson(e)).toList();

      allPosters.refresh();
      setTabController(allPosters.length);
    } catch (e) {
      repository.errorHandler(
        title: "Could not get posters",
        message: e.toString(),
      );
    }
  }

  searchPosters() async {
    try {
      var mappedSearchCategories = {};
      for (int i = 0; i < selectedCategories.length; i++) {
        mappedSearchCategories["category_id $i"] = selectedCategories[i];
      }

      var res = await repository.getData(
        collection: "products",
        searchCriteria: {
          "title true": searchController.text,
          ...mappedSearchCategories,
        },
      );

      foundPosters.value = res.map((e) => PosterModel.fromJson(e)).toList();

      foundPosters.refresh();
    } catch (e) {
      repository.errorHandler(
        title: "Could not get posters",
        message: e.toString(),
      );
    }
  }
  // ****************************************************

  // Dispose
  @override
  void onClose() {
    super.onClose();
    timer?.cancel();
    searchFocusNode.dispose();
    searchController.dispose();
    tabController?.dispose();
  }

  // ****************************************************
}
