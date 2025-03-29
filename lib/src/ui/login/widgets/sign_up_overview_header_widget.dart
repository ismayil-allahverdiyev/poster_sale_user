import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../controllers/login/login_controller.dart';
import '../../widgets/source/custom_smooth_indicator_widget.dart';
import '../../widgets/source/custom_tabbar_view.dart';
import 'login_title_widget.dart';

class SignUpOverviewHeaderWidget extends GetWidget<LoginController> {
  const SignUpOverviewHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: Get.height / 5 * 2,
          child: CustomTabBarView(
            tabController: controller.tabController,
            isScrollable: false,
            widgets: const [
              LoginTitleWidget(
                image: Assets.sign_up_image,
                title: "Sign Up",
              ),
              LoginTitleWidget(
                image: Assets.sign_in_image,
                title: "Sign In",
              ),
            ],
            height: Get.height / 5 * 2,
          ),
        ),
        Positioned(
          top: 64,
          left: 16,
          child: Obx(
            () {
              return CustomSmoothIndicator(
                selectedIndex: controller.selectedIndex.value,
                count: controller.tabController?.length ?? 0,
                isExpanding: true,
                onDotClicked: (index) {},
              );
            },
          ),
        )
      ],
    );
  }
}
