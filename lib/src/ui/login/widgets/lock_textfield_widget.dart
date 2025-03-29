import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../controllers/login/login_controller.dart';

class LockTextfieldWidget extends GetWidget<LoginController> {
  const LockTextfieldWidget({
    super.key,
    required this.isSign,
  });
  final bool isSign;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSign) {
          controller.isSignPasswordOn.value =
              !controller.isSignPasswordOn.value;
          return;
        }
        controller.isPasswordOn.value = !controller.isPasswordOn.value;
      },
      child: Obx(
        () {
          return Image.asset(
            (isSign
                    ? controller.isSignPasswordOn.value
                    : controller.isPasswordOn.value)
                ? Assets.icon_eye
                : Assets.icon_eye_slash,
          );
        },
      ),
    );
  }
}
