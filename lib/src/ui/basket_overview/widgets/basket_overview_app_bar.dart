import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';

import '../../../constants/assets.dart';
import '../../widgets/source/custom_icon_button.dart';
import 'finalize_button_widget.dart';

class BasketOverviewAppBar extends StatelessWidget {
  const BasketOverviewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Container(
          decoration: BoxDecoration(
            color: secondaryColor.withOpacity(0.1),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Get.width * 0.04,
              Get.width * 0.15,
              Get.width * 0.04,
              Get.width * 0.05,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  assetPath: Assets.icon_arrow_left,
                  onTap: () {
                    Get.back();
                  },
                ),
                const Expanded(
                  child: FinalizeButtonWidget(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
