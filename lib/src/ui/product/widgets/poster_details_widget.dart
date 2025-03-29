import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/product/product_controller.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';

import '../../theme/app_colors.dart';

class PosterDetailsWidget extends GetWidget<ProductController> {
  const PosterDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Obx(() {
            return controller.poster.value == null || !controller.isLoaded.value
                ? const CustomDescriptionLoader()
                : SizedBox(
                    width: Get.width * 0.8,
                    child: Text(
                      controller.poster.value!.title,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
          }),
          const SizedBox(
            height: 8,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, top: 8),
                child: Obx(() {
                  return controller.poster.value == null ||
                          !controller.isLoaded.value
                      ? CustomShimmer(
                          child: Container(
                            height: 18,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: whiteColor,
                            ),
                          ),
                        )
                      : Text(
                          "${controller.poster.value!.price}\$",
                          style: const TextStyle(
                            fontSize: 20,
                            height: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                }),
              ),
              Obx(() {
                return controller.poster.value == null ||
                        !controller.isLoaded.value
                    ? const CustomDescriptionLoader(
                        isEnd: true,
                      )
                    : Expanded(
                        child: Text(
                          controller.poster.value!.description,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontSize: 14,
                            height: 1,
                            fontWeight: FontWeight.bold,
                            color: lightBlueTextColor,
                          ),
                        ),
                      );
              }),
            ],
          )
        ],
      ),
    );
  }
}

class CustomDescriptionLoader extends StatelessWidget {
  final bool isEnd;
  const CustomDescriptionLoader({
    super.key,
    this.isEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Column(
        crossAxisAlignment:
            isEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            height: 12,
            width: Get.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: whiteColor,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 12,
            width: Get.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: whiteColor,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 12,
            width: Get.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
