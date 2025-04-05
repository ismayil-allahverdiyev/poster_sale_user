import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/login/login_controller.dart';
import 'package:poster_sale_user/src/ui/login/widgets/forget_password_body_widget.dart';
import 'package:poster_sale_user/src/ui/login/widgets/sign_in_body_widget.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_tabbar_view.dart';
import '../widgets/source/custom_loader_page.dart';
import '../widgets/source/custom_scaffold.dart';
import 'widgets/sign_up_overview_header_widget.dart';
import 'widgets/sing_up_body_widget.dart';

class SignUpOverviewPage extends GetView<LoginController> {
  const SignUpOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomScaffold(
          hasAppBar: false,
          padding: EdgeInsets.zero,
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SignUpOverviewHeaderWidget(),
                  CustomTabBarView(
                    tabController: controller.tabController,
                    widgets: const [
                      SignUpBodyWidget(),
                      SignInBodyWidget(),
                      ForgetPasswordBodyWidget()
                    ],
                    height: Get.height / 5 * 3,
                    isScrollable: false,
                  )
                ],
              ),
            )
          ],
        ),
        Positioned(
          child: Obx(
            () {
              return controller.isLoading.value
                  ? const CustomLoaderPage()
                  : const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
