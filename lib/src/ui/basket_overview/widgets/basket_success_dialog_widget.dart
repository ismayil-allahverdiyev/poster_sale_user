import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/constants/assets.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_rounded_button.dart';
import '../../../ui/widgets/source/custom_dialog_wrapper_widget.dart';

class BasketSuccessDialogWidget extends StatelessWidget {
  const BasketSuccessDialogWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialogWrapperWidget(
      padding: const EdgeInsets.all(8),
      children: [
        const Text(
          "Thank you for contacting us",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "We will contact you soon",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: lightBlueTextColor,
          ),
        ),
        Image.asset(
          Assets.image_verify,
          scale: 3,
        ),
        CustomRoundedButton(
          onTap: () {
            Get.back();
          },
          message: "Close",
          backgroundColor: primaryColor,
          textColor: whiteColor,
          width: Get.width * 0.5,
        )
      ],
    );
  }
}
