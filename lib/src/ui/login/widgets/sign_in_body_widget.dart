import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../controllers/login/login_controller.dart';
import '../../../routes/app_routes.dart';
import '../../widgets/source/custom_large_button_widget.dart';
import '../../widgets/source/custom_simple_text_field.dart';
import '../../widgets/source/custom_text_button_widget.dart';
import 'lock_textfield_widget.dart';

class SignInBodyWidget extends GetWidget<LoginController> {
  const SignInBodyWidget({
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
                  controller: controller.signInEmailController,
                  maxLines: 1,
                  prefixIcon: Image.asset(Assets.icon_sms),
                ),
                const SizedBox(
                  height: 8,
                ),
                Obx(
                  () {
                    return CustomSimpleTextField(
                      hintText: "Password",
                      controller: controller.signInPasswordController,
                      prefixIcon: Image.asset(Assets.icon_lock_2),
                      suffixIcon: const LockTextfieldWidget(
                        isSign: true,
                      ),
                      isObscure: controller.isSignPasswordOn.value,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomTextButtonWidget(
                    onPressed: () {
                      controller.tabController?.animateTo(2);
                    },
                    isDense: true,
                    title: "Forgot password?",
                  ),
                ),
              ],
            ),
          ),
          CustomLargeButtonWidget(
            title: "Log in",
            onTap: () => controller.signIn(),
          ),
          CustomTextButtonWidget(
            onPressed: () {
              controller.tabController?.animateTo(0);
            },
            title: "You don’t have an account?",
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
