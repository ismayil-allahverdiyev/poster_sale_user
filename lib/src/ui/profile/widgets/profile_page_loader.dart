import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../widgets/source/custom_divider.dart';
import '../../widgets/source/custom_shimmer_wrapper_widget.dart';

class ProfilePageLoader extends StatelessWidget {
  const ProfilePageLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        itemCount: 8,
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: Get.width * 0.12 + 48),
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: whiteColor,
              ),
            ),
            title: Container(
              width: Get.width * 0.3,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: whiteColor,
              ),
            ),
            subtitle: Container(
              width: Get.width * 0.5,
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: whiteColor,
              ),
            ),
            dense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
          );
        },
        separatorBuilder: (context, index) => const CustomDivider(),
      ),
    );
  }
}
