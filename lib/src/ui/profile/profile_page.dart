import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/profile/profile_controller.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import 'widgets/basket_list_widget.dart';
import 'widgets/profile_app_bar.dart';
import 'widgets/profile_user_info_tile.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasAppBar: false,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 48,
        ),
        const ProfileUserInfoTile(),
        const ProfileAppBar(),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: Obx(
            () {
              return !controller.isLoaded.value
                  ? ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const BasketListWidgetLoader();
                      },
                    )
                  : ListView.builder(
                      itemCount: controller.previousOrders.length,
                      padding: EdgeInsets.only(bottom: Get.width * 0.12 + 48),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return BasketListWidget(
                          basket: controller.previousOrders[index],
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
