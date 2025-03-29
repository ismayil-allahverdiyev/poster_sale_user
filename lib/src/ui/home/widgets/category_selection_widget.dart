import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../controllers/home/home_controller.dart';
import '../../theme/app_colors.dart';
import '../loader/category_shimmer_list_widget.dart';

class CategorySelectionWidget extends GetWidget<HomeController> {
  const CategorySelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: Get.width,
          height: Get.width * 0.3,
          child: Obx(
            () {
              return controller.categories.isEmpty
                  ? const CategoryShimmerListWidget()
                  : Obx(
                      () {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 8 : 0),
                              child: GestureDetector(
                                onTap: () {
                                  controller.onCategorySelected(index);
                                },
                                child: Obx(
                                  () {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        CachedNetworkImage(
                                          imageUrl: controller
                                              .categories[index].image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  CircleAvatar(
                                            radius: Get.width * 0.09,
                                            backgroundColor: ((controller
                                                            .isFocused.value ||
                                                        controller.isSearchIsOn
                                                            .value) &&
                                                    controller
                                                        .selectedCategories
                                                        .contains(controller
                                                            .categories[index]
                                                            .id))
                                                ? lightBlueColor
                                                : primaryColor,
                                            child: Image(
                                              image: imageProvider,
                                              width: 24,
                                              height: 24,
                                            ),
                                          ),
                                          progressIndicatorBuilder:
                                              (context, url, progress) =>
                                                  CircleAvatar(
                                            radius: Get.width * 0.09,
                                            backgroundColor: ((controller
                                                            .isFocused.value ||
                                                        controller.isSearchIsOn
                                                            .value) &&
                                                    controller
                                                        .selectedCategories
                                                        .contains(controller
                                                            .categories[index]
                                                            .id))
                                                ? lightBlueColor
                                                : primaryColor,
                                            child: const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(
                                                  lightBlueColor,
                                                ),
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          controller.categories[index].title,
                                          style: TextStyle(
                                            color: ((controller
                                                            .isFocused.value ||
                                                        controller.isSearchIsOn
                                                            .value) &&
                                                    controller
                                                        .selectedCategories
                                                        .contains(controller
                                                            .categories[index]
                                                            .id))
                                                ? lightBlueColor
                                                : textColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 12,
                          ),
                          itemCount: controller.categories.length,
                        );
                      },
                    );
            },
          ),
        ),
        Positioned(
          right: -1,
          top: 0,
          bottom: 0,
          child: Container(
            width: 80,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
