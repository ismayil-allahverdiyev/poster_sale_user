import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/settings/settings_controller.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import '../../constants/assets.dart';
import '../widgets/source/custom_icon_button.dart';
import '../widgets/source/custom_loader_page.dart';

class SettingsPage extends GetView<SettingsController> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomScaffold(
          hasAppBar: false,
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
            ),
            CustomIconButton(
              assetPath: Assets.icon_arrow_left,
              onTap: () {
                Get.back();
              },
            ),
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
