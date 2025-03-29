import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';
import '../source/custom_dialog_wrapper_widget.dart';
import '../source/custom_rounded_button.dart';

class BlockedUserDialog extends StatelessWidget {
  const BlockedUserDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogWrapperWidget(
      children: [
        const Text(
          "Blocked user",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Text(
          "You have blocked this user",
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
            Assets.icon_lock,
            width: Get.width * 0.1,
            color: whiteColor,
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: CustomRoundedButton(
                  message: "Close",
                  onTap: () => Get.back(),
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: CustomRoundedButton(
                  message: "Unblock",
                  backgroundColor: primaryColor,
                  textColor: whiteColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
