import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Container(
          width: Get.width,
          color: textColor,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text(
              'Previous orders',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
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
