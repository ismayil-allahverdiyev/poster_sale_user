import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/login/login_controller.dart';
import 'package:poster_sale_user/src/ui/login/widgets/sign_in_body_widget.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_large_button_widget.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_tabbar_view.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_text_button_widget.dart';
import '../../constants/assets.dart';
import '../widgets/source/custom_scaffold.dart';
import '../widgets/source/custom_simple_text_field.dart';
import 'widgets/lock_textfield_widget.dart';
import 'widgets/sign_up_overview_header_widget.dart';
import 'widgets/sing_up_body_widget.dart';

class SignUpOverviewPage extends GetView<LoginController> {
  const SignUpOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
                ],
                height: Get.height / 5 * 3,
                isScrollable: false,
              )
            ],
          ),
        )
      ],
    );
  }
}
