import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/product/product_controller.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import '../widgets/source/custom_smooth_indicator_widget.dart';
import '../widgets/source/message_text_field.dart';
import 'widgets/image_tabbar_widget.dart';
import 'widgets/poster_details_widget.dart';
import 'widgets/product_app_bar_widget.dart';

class ProductPage extends GetView<ProductController> {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasAppBar: false,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 48,
        ),
        const ProductAppBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const ImageTabBar(),
              Obx(
                () {
                  return CustomSmoothIndicator(
                    selectedIndex: controller.selectedIndex.value,
                    count: controller.tabController?.length ?? 1,
                    onDotClicked: (index) =>
                        controller.tabController!.animateTo(index),
                  );
                },
              ),
              const PosterDetailsWidget()
            ],
          ),
        ),
        // *Reminder* Turn on for user app

        // Column(
        //   children: [
        //     const Text(
        //       "Any question?",
        //       style: TextStyle(
        //         fontWeight: FontWeight.w600,
        //       ),
        //     ),
        //     MessageTextField(
        //       controller: controller.messageController,
        //     ),
        //     const SizedBox(
        //       height: 16,
        //     ),
        //   ],
        // )
      ],
    );
  }
}
