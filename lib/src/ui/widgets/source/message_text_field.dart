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
    return Obx(() {
      final isEnabled = controller.chatStatus.value != ChatStatus.blocked;
      return CustomMessageTextField(
        textController: textController,
        onSend: onSend,
        padding: padding,
        enabled: isEnabled,
        sendButtonColor:
            isEnabled ? primaryColor : primaryColor.withOpacity(0.3),
      );
    });
  }
}

class CustomMessageTextField extends StatelessWidget {
  const CustomMessageTextField({
    super.key,
    required this.textController,
    required this.onSend,
    this.padding,
    this.enabled = true,
    this.sendButtonColor,
  });

  final TextEditingController textController;
  final Function() onSend;
  final EdgeInsets? padding;
  final bool enabled;
  final Color? sendButtonColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: CustomTextField(
        hintText: "Type your question...",
        controller: textController,
        enabled: enabled,
        hintStyle: const TextStyle(
          color: lightBlueTextColor,
          fontSize: 14,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: SizedBox(
            child: InkWell(
              onTap: enabled ? onSend : null,
              borderRadius: BorderRadius.circular(1000),
              splashColor: Colors.transparent,
              child: CircleAvatar(
                backgroundColor: sendButtonColor ?? primaryColor,
                child: Image.asset(
                  Assets.icon_send,
                  scale: 3,
                ),
              ),
            ),
          ),
        ),
        isRounded: true,
      ),
    );
  }
}
