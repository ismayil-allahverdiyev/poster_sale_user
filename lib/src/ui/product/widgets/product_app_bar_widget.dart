import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/constants/data.dart';
import '../../../constants/assets.dart';
import '../../../controllers/product/product_controller.dart';
import '../../widgets/source/custom_icon_button.dart';
import 'poster_date_loader_widget.dart';

class ProductAppBar extends GetWidget<ProductController> {
  const ProductAppBar({
    super.key,
  });

  String formatDateToMonthYear(DateTime date) {
    return "${MonthNames[date.month - 1]} ${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            assetPath: Assets.icon_arrow_left,
            onTap: () {
              Get.back();
            },
          ),
          Obx(
            () {
              return controller.poster.value == null
                  ? const PosterDateLoaderWidget()
                  : Text(
                      "${formatDateToMonthYear(controller.poster.value!.startDate)} - ${formatDateToMonthYear(controller.poster.value!.endDate)}",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
            },
          ),
          Obx(
            () {
              return CustomIconButton(
                assetPath: controller.isInBasket.value
                    ? Assets.icon_bag_tick
                    : Assets.icon_add_bag,
                onTap: () {
                  controller.addToBasket();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
