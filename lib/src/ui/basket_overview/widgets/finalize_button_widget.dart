import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/basket_overview/basket_overview_controller.dart';
import 'package:poster_sale_user/src/routes/app_routes.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';

class FinalizeButtonWidget extends GetWidget<BasketOverviewController> {
  const FinalizeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.MESSAGESDETAILED),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: Get.width * 0.15,
                decoration: BoxDecoration(
                  color: textColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.width * 0.5,
                      child: const Center(
                        child: Text(
                          "Checkout",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: Get.width * 0.15,
                        width: 2,
                        color: greyColor,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(() {
                            return Text(
                              controller.isLoading.value
                                  ? ""
                                  : "${controller.totalPrice}\$",
                              style: const TextStyle(
                                fontSize: 12,
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: Get.width * -0.15,
                right: Get.width * -0.1,
                child: CircleAvatar(
                  radius: Get.width * 0.15,
                  backgroundColor: lightGreyColor.withOpacity(0.2),
                ),
              )
            ],
          ),
          Positioned(
            top: Get.width * -0.3,
            child: Image.asset(
              Assets.complex_background,
            ),
          ),
        ],
      ),
    );
  }
}
