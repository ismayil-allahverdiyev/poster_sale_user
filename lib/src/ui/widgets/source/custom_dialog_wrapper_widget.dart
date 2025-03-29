import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';

class CustomDialogWrapperWidget extends StatelessWidget {
  final List<Widget> children;
  final double? width;
  final double? height;

  const CustomDialogWrapperWidget({
    super.key,
    required this.children,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: width ?? Get.width * 0.9,
          height: height ?? null,
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Material(
              color: whiteColor,
              borderRadius: BorderRadius.circular(8),
              child: Column(
                children: children,
              ),
            ),
          ),
        )
      ],
    );
  }
}
