import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/messages_detailed/messages_detailed_controller.dart';
import 'package:poster_sale_user/src/ui/messages_detailed/widgets/image_carousel_in_chat_widget.dart';
import 'package:poster_sale_user/src/ui/messages_detailed/widgets/messages_detailed_app_bar.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import '../widgets/source/message_text_field.dart';
import '../widgets/source/text/text_list_widget.dart';

class MessagesDetailedPage extends GetView<MessagesDetailedController> {
  const MessagesDetailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasAppBar: false,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 48,
        ),
        const MessagesDetailedAppBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView(
            controller: controller.scrollController,
            children: const [
              ImageCarouselInChatWidget(),
              TextListWidget(),
              SizedBox(
                height: 64,
              ),
            ],
          ),
        ),
        Column(
          children: [
            MessageTextField(
              textController: controller.messageController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              onSend: controller.sendMessage,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        )
      ],
    );
  }
}
