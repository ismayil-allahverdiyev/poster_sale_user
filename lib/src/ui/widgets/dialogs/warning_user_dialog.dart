import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';
import '../source/custom_dialog_wrapper_widget.dart';
import '../source/custom_rounded_button.dart';

class WarningUserDialog extends StatelessWidget {
  const WarningUserDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogWrapperWidget(
      children: [
        const Text(
          "Timeout",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          "You have been timed out from this chat",
          style: TextStyle(
            fontSize: 14,
            color: lightBlueTextColor,
          ),
        ),
        const SizedBox(height: 8),
        CircleAvatar(
          radius: Get.width * 0.12,
          backgroundColor: primaryColor,
          child: Image.asset(
            Assets.icon_clock,
            width: Get.width * 0.1,
            color: whiteColor,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomRoundedButton(
            message: "Close",
            onTap: () => Get.back(),
          ),
        )
      ],
    );
  }
}
