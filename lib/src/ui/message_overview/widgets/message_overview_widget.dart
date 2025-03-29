import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';
import '../../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/dialogs/blocked_user_dialog.dart';
import '../../widgets/dialogs/warning_user_dialog.dart';
import '../../widgets/source/custom_icon_button.dart';

class MessageOverviewWidget extends StatelessWidget {
  const MessageOverviewWidget({
    super.key,
    required this.warningType,
    required this.title,
    required this.message,
  });

  final int warningType;
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed(Routes.MESSAGESDETAILED),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      leading: Container(
        height: Get.width * 0.1,
        width: Get.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: const DecorationImage(
            image: AssetImage(Assets.test_image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color: lightBlueTextColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: warningType == 0
          ? null
          : warningType == 1
              ? CustomIconButton(
                  assetPath: Assets.icon_clock,
                  onTap: () {
                    Get.dialog(
                      const WarningUserDialog(),
                    );
                  },
                )
              : CustomIconButton(
                  assetPath: Assets.icon_warning,
                  onTap: () {
                    Get.dialog(
                      const BlockedUserDialog(),
                    );
                  },
                ),
    );
  }
}
