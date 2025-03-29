import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/routes/app_routes.dart';
import '../../theme/app_colors.dart';

class CustomLargeButtonWidget extends StatelessWidget {
  const CustomLargeButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: Get.width * 0.15,
              decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: Get.width * -0.3,
            right: Get.width * -0.15,
            child: CircleAvatar(
              radius: Get.width * 0.25,
              backgroundColor: lightGreyColor.withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
