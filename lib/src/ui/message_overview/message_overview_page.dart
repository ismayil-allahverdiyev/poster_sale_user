import 'package:flutter/material.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import 'widgets/message_overview_widget.dart';

class MessageOverviewPage extends StatelessWidget {
  const MessageOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        Expanded(
          child: ListView.separated(
            itemCount: 5,
            padding: const EdgeInsets.only(bottom: 200),
            separatorBuilder: (context, index) {
              return const Divider(
                height: 1,
                color: lightGreyColor,
              );
            },
            itemBuilder: (context, index) {
              return MessageOverviewWidget(
                warningType: index % 3,
                title:
                    "This artwork of blue and white clouds again and something more",
                message:
                    "I wanted to know if we can collaborate. And possibly do a lot more",
              );
            },
          ),
        )
      ],
    );
  }
}
