import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/profile/profile_controller.dart';

import '../../../constants/assets.dart';
import '../../../routes/app_routes.dart';
import '../../theme/app_colors.dart';
import '../../widgets/source/custom_shimmer_wrapper_widget.dart';

class ProfileUserInfoTile extends GetWidget<ProfileController> {
  const ProfileUserInfoTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 8,
      leading: CircleAvatar(
        radius: Get.width * 0.06,
        backgroundColor: lightBlueTextColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            Assets.icon_profile,
          ),
        ),
      ),
      title: Obx(
        () {
          return controller.user.value == null
              ? CustomShimmer(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              : Text(
                  controller.user.value?.name ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                );
        },
      ),
      subtitle: Obx(
        () {
          return controller.user.value == null
              ? CustomShimmer(
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                )
              : Text(
                  controller.user.value!.timestamp.toDate().toString(),
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                );
        },
      ),
      trailing: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Get.toNamed(Routes.SETTINGS);
        },
        child: const CircleAvatar(
          radius: 20,
          backgroundColor: lightBlueTextColor,
          child: Icon(
            Icons.settings,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
