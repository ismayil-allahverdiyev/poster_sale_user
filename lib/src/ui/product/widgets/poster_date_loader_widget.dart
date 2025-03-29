import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/app_colors.dart';
import '../../widgets/source/custom_shimmer_wrapper_widget.dart';

class PosterDateLoaderWidget extends StatelessWidget {
  const PosterDateLoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        width: Get.width / 3,
        height: 16,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
