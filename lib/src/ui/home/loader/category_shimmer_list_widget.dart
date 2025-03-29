import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';
import 'package:shimmer/shimmer.dart';
import '../../theme/app_colors.dart';

class CategoryShimmerListWidget extends StatelessWidget {
  const CategoryShimmerListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: index == 0 ? 8 : 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                CircleAvatar(
                  radius: Get.width * 0.09,
                  backgroundColor: whiteColor,
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: Get.width * 0.1,
                  height: 16,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
          width: 12,
        ),
        itemCount: 7,
      ),
    );
  }
}
