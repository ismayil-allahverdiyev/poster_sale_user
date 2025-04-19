import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/message_overview/message_overview_controller.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import 'widgets/message_overview_widget.dart';

class MessageOverviewPage extends GetWidget<MessageOverviewController> {
  const MessageOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        Expanded(
          child: Obx(
            () {
              return ListView.separated(
                itemCount: controller.chatList.length,
                padding: const EdgeInsets.only(bottom: 200),
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                    color: lightGreyColor,
                  );
                },
                itemBuilder: (context, index) {
                  return MessageOverviewWidget(
                    chat: controller.chatList[index],
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
