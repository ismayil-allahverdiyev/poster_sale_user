import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/messages_detailed/messages_detailed_controller.dart';
import 'text_box_widget.dart';

class TextListWidget extends GetWidget<MessagesDetailedController> {
  const TextListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.messageList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var message = controller.messageList[index];
            return TextBox(
              index: index,
              message: message,
              hasDate: index == 0 ||
                  isDifferentDay(
                    message.timestamp.toDate(),
                    controller.messageList[index - 1].timestamp.toDate(),
                  ),
            );
          },
        );
      },
    );
  }
}

bool isDifferentDay(DateTime current, DateTime previous) {
  return current.year != previous.year ||
      current.month != previous.month ||
      current.day != previous.day;
}
