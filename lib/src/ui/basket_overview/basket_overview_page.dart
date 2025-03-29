import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/baskets_overview/baskets_overview_controller.dart';
import 'package:poster_sale_user/src/ui/basket_overview/widgets/basket_product_widget.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import '../widgets/source/custom_divider.dart';
import 'widgets/basket_overview_app_bar.dart';

class BasketOverviewPage extends GetView<BasketsOverviewController> {
  const BasketOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasAppBar: false,
      padding: EdgeInsets.zero,
      children: [
        const BasketOverviewAppBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return BasketProductWidget(index: index);
            },
            separatorBuilder: (context, index) => const CustomDivider(),
          ),
        ),
      ],
    );
  }
}
