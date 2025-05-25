import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';
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
          PopupMenuButton(
            color: whiteColor,
            menuPadding: const EdgeInsets.all(0),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                child: const Text(
                  "Add to basket",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                onTap: () => {},
              ),
            ],
            child: Image.asset(
              Assets.icon_dots,
              scale: 3,
            ),
          )
        ],
      ),
    );
  }
}
