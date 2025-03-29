import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/routes/app_routes.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';

class FinalizeButtonWidget extends StatelessWidget {
  const FinalizeButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.MESSAGESDETAILED),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Stack(
            children: [
              Container(
                height: Get.width * 0.15,
                width: Get.width * 0.8,
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
                          "Finalize",
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
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "100\$",
                            style: TextStyle(
                              fontSize: 12,
                              color: whiteColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
