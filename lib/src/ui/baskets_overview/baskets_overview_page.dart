import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/baskets_overview/baskets_overview_controller.dart';
import 'package:poster_sale_user/src/ui/baskets_overview/widgets/baskets_overview_app_bar.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import '../widgets/source/custom_divider.dart';
import 'widgets/baskets_overview_widget.dart';

class BasketsOverviewPage extends GetView<BasketsOverviewController> {
  const BasketsOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasAppBar: false,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 48,
        ),
        const BasketsOverviewAppBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return BasketsOverviewWidget(index: index);
            },
            separatorBuilder: (context, index) => const CustomDivider(),
          ),
        ),
      ],
    );
  }
}
