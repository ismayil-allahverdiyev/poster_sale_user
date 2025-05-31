import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/ui/basket_overview/widgets/basket_product_widget.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';
import '../../controllers/basket_overview/basket_overview_controller.dart';
import '../widgets/source/custom_divider.dart';
import 'widgets/basket_overview_app_bar.dart';

class BasketOverviewPage extends GetView<BasketOverviewController> {
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
          child: Obx(
            () {
              return controller.isLoading.value
                  ? ListView.separated(
                      itemCount: 10,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return const BasketProductWidgetLoader();
                      },
                      separatorBuilder: (context, index) =>
                          const CustomShimmer(child: CustomDivider()),
                    )
                  : ListView.separated(
                      itemCount: controller.basketItems.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return BasketProductWidget(
                          basketItem: controller.basketItems[index],
                          onRemove: () => controller.removeItemFromBasket(
                            controller.basketItems[index].id,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const CustomDivider(),
                    );
            },
          ),
        ),
      ],
    );
  }
}
