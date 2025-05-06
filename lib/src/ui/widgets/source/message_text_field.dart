import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/messages_detailed/messages_detailed_controller.dart';
import '../../../constants/assets.dart';
import '../../../data/models/chat/chat_model.dart';
import '../../theme/app_colors.dart';
import 'custom_text_field.dart';

class MessageTextField extends GetWidget<MessagesDetailedController> {
  const MessageTextField({
    super.key,
    required this.textController,
    required this.onSend,
    this.padding,
  });

  final TextEditingController textController;
  final Function() onSend;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: Obx(
        () {
          return CustomTextField(
            hintText: "Type your question...",
            controller: textController,
            enabled: controller.chatStatus.value != ChatStatus.blocked,
            hintStyle: const TextStyle(
              color: lightBlueTextColor,
              fontSize: 14,
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: SizedBox(
                child: InkWell(
                  onTap: onSend,
                  borderRadius: BorderRadius.circular(1000),
                  splashColor: Colors.transparent,
                  child: Obx(
                    () {
                      return CircleAvatar(
                        backgroundColor:
                            controller.chatStatus.value != ChatStatus.blocked
                                ? primaryColor
                                : primaryColor.withOpacity(0.3),
                        child: Image.asset(
                          Assets.icon_send,
                          scale: 3,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            isRounded: true,
          );
        },
      ),
    );
  }
}
