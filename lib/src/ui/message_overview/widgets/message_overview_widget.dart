import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/chat/chat_model.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';
import '../../../constants/assets.dart';
import '../../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/dialogs/blocked_user_dialog.dart';
import '../../widgets/dialogs/warning_user_dialog.dart';
import '../../widgets/source/custom_icon_button.dart';

class MessageOverviewWidget extends StatelessWidget {
  const MessageOverviewWidget({
    super.key,
    required this.chat,
  });

  final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed(
        Routes.MESSAGESDETAILED,
        parameters: {
          "posterId": chat.productId,
          "chatId": chat.id,
        },
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      leading: CachedNetworkImage(
        imageUrl: chat.productImage,
        imageBuilder: (context, imageProvider) => Container(
          height: Get.width * 0.1,
          width: Get.width * 0.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const ChatProductImageLoader(),
        errorWidget: (context, url, error) => const ChatProductImageLoader(),
      ),
      title: Text(
        chat.productTitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: lightBlueTextColor,
        ),
      ),
      subtitle: Text(
        chat.lastMessage,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 14,
          color: chat.read ? lightBlueTextColor : greyColor,
          fontWeight: chat.read ? FontWeight.w600 : FontWeight.bold,
        ),
      ),
      trailing: chat.chatStatus == ChatStatus.normal
          ? null
          : chat.chatStatus == ChatStatus.timeout
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

class ChatProductImageLoader extends StatelessWidget {
  const ChatProductImageLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        height: Get.width * 0.1,
        width: Get.width * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: lightGreyColor,
        ),
      ),
    );
  }
}
