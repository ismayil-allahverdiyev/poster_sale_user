import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/messages_detailed/messages_detailed_controller.dart';
import 'package:poster_sale_user/src/data/models/message/message_model.dart';

import '../../../theme/app_colors.dart';

class TextBox extends GetWidget<MessagesDetailedController> {
  const TextBox({
    super.key,
    required this.index,
    required this.message,
  });

  final int index;
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment:
            checkUserId() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.75),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: checkUserId() ? primaryColor : lightGreyColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(8),
                  bottomRight: const Radius.circular(8),
                  topLeft: checkUserId()
                      ? const Radius.circular(8)
                      : const Radius.circular(0),
                  topRight: checkUserId()
                      ? const Radius.circular(0)
                      : const Radius.circular(8),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  color: checkUserId() ? whiteColor : primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool checkUserId() => (controller.userId.value == message.senderId);
}
