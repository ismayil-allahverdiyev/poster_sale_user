import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';

import '../../../controllers/product/product_controller.dart';
import '../../widgets/source/custom_tabbar_view.dart';
import 'poster_detailed_image_widget.dart';

class ImageTabBar extends GetWidget<ProductController> {
  const ImageTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.poster.value == null || !controller.isLoaded.value
            ? CustomShimmer(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      Get.width * 0.05, 0, Get.width * 0.05, 12),
                  child: Container(
                    width: Get.width,
                    height: Get.width * 1.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              )
            : CustomTabBarView(
                tabController: controller.tabController,
                hasControlledAnimation: false,
                widgets: controller.poster.value!.images
                    .map(
                      (image) => PosterDetailedImage(
                        image: image,
                      ),
                    )
                    .toList() as List<Widget>,
                height: Get.width * 1.3,
              );
      },
    );
  }
}
