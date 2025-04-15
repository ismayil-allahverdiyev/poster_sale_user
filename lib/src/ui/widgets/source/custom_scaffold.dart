import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/utils/device_utils.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_app_bar.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;
  final bool hasAppBar;
  final Widget? floatingActionButton;

  const CustomScaffold({
    super.key,
    required this.children,
    this.padding,
    this.hasAppBar = true,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => DeviceUtils.hideKeyboard(context),
      child: Scaffold(
        backgroundColor: whiteColor,
        body: Stack(
          children: [
            Column(
              children: [
                hasAppBar ? const CustomAppBar() : const SizedBox(),
                Expanded(
                  child: Padding(
                    padding: padding ??
                        EdgeInsets.symmetric(
                          horizontal: Get.width * 0.04,
                        ),
                    child: Column(
                      children: children,
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
