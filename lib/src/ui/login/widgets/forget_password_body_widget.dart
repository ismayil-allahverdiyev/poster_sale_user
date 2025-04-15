import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../controllers/login/login_controller.dart';
import '../../widgets/source/custom_large_button_widget.dart';
import '../../widgets/source/custom_simple_text_field.dart';
import '../../widgets/source/custom_text_button_widget.dart';

class ForgetPasswordBodyWidget extends GetWidget<LoginController> {
  const ForgetPasswordBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height / 5 * 3,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(
                  height: 12,
                ),
                CustomSimpleTextField(
                  hintText: "E-mail",
                  controller: controller.forgetPasswordEmailController,
                  maxLines: 1,
                  prefixIcon: Image.asset(Assets.icon_sms),
                ),
              ],
            ),
          ),
          CustomLargeButtonWidget(
            title: "Reset password",
            onTap: () => controller.sendPasswordResetEmail(),
          ),
          CustomTextButtonWidget(
            title: "Get Back",
            onPressed: () => controller.tabController!.animateTo(1),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
