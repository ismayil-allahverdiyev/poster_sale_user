import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import 'custom_dialog_wrapper_widget.dart';
import 'custom_rounded_button.dart';

class CustomImageSelectorDialog extends StatelessWidget {
  final Function() onGalleryTap;
  final Function() onCameraTap;
  const CustomImageSelectorDialog({
    super.key,
    required this.onGalleryTap,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogWrapperWidget(
      children: [
        const SizedBox(
          height: 8,
        ),
        const Text(
          "Select Image",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: CustomRoundedButton(
            backgroundColor: primaryColor,
            textColor: whiteColor,
            onTap: onGalleryTap,
            message: "Gallery",
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: CustomRoundedButton(
            backgroundColor: primaryColor,
            textColor: whiteColor,
            onTap: onCameraTap,
            message: "Camera",
          ),
        ),
      ],
    );
  }
}
