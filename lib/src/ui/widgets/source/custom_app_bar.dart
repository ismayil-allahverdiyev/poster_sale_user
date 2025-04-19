import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Get.width * 0.04,
              Get.width * 0.15,
              Get.width * 0.04,
              Get.width * 0.05,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: CircleAvatar(
                    radius: Get.width * 0.07,
                    backgroundColor: primaryColor,
                    child: Image.asset(
                      Assets.icon_category,
                      scale: 3,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.6,
                  child: Column(
                    children: [
                      Text(
                        "Originally from",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: lightBlueTextColor,
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Dortmund, Germany",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: textColor,
                          fontSize: Get.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: Get.width * 0.07,
                  backgroundColor: greyColor,
                  child: const Text("ME"),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: Get.width * -0.3,
          child: Image.asset(
            Assets.complex_background,
          ),
        ),
      ],
    );
  }
}
