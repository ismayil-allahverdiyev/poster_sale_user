import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/messages_detailed/messages_detailed_controller.dart';
import '../../../theme/app_colors.dart';
import 'text_box_widget.dart';

class TextListWidget extends GetWidget<MessagesDetailedController> {
  const TextListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "12 December",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: lightBlueTextColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: controller.messages.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return TextBox(
              index: index,
              text: controller.messages[index],
            );
          },
        ),
      ],
    );
  }
}
