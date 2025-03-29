import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../controllers/login/login_controller.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/source/custom_large_button_widget.dart';
import '../../widgets/source/custom_simple_text_field.dart';
import '../../widgets/source/custom_text_button_widget.dart';
import 'lock_textfield_widget.dart';

class SignUpBodyWidget extends GetWidget<LoginController> {
  const SignUpBodyWidget({
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
                  prefixIcon: Image.asset(Assets.icon_sms),
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () {
                    return CustomSimpleTextField(
                      hintText: "Password",
                      prefixIcon: Image.asset(Assets.icon_lock_2),
                      suffixIcon: const LockTextfieldWidget(
                        isSign: false,
                      ),
                      isObscure: controller.isPasswordOn.value,
                    );
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () {
                    return CustomSimpleTextField(
                      hintText: "Repeat Password",
                      prefixIcon: Image.asset(Assets.icon_lock_2),
                      suffixIcon: const LockTextfieldWidget(
                        isSign: false,
                      ),
                      isObscure: controller.isPasswordOn.value,
                    );
                  },
                ),
              ],
            ),
          ),
          CustomLargeButtonWidget(
            title: "Finalize",
            onTap: () => Get.toNamed(Routes.BOTTOM),
          ),
          CustomTextButtonWidget(
            onPressed: () {
              controller.tabController?.animateTo(1);
            },
            title: "Already have an account?",
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
