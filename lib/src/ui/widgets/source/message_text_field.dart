import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';
import 'custom_text_field.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.controller,
    required this.onSend,
    this.padding,
  });

  final TextEditingController controller;
  final Function() onSend;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: CustomTextField(
        hintText: "Type your question...",
        controller: controller,
        hintStyle: const TextStyle(
          color: lightBlueTextColor,
          fontSize: 14,
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
          ),
          child: InkWell(
            radius: 100,
            onTap: onSend,
            child: CircleAvatar(
              backgroundColor: primaryColor,
              child: Image.asset(
                Assets.icon_send,
                scale: 3,
              ),
            ),
          ),
        ),
        isRounded: true,
      ),
    );
  }
}
