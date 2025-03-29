import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../widgets/source/custom_icon_button.dart';

class MessagesDetailedAppBar extends StatelessWidget {
  const MessagesDetailedAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            assetPath: Assets.icon_arrow_left,
            onTap: () {
              Get.back();
            },
          ),
          CustomIconButton(
            assetPath: Assets.icon_dots,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
