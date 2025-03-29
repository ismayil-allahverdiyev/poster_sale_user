import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';

class PosterDetailedImage extends StatelessWidget {
  final String image;
  const PosterDetailedImage({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(Get.width * 0.05, 0, Get.width * 0.05, 12),
      child: CachedNetworkImage(
        imageUrl: image,
        imageBuilder: (context, imageProvider) => Container(
          width: Get.width,
          height: Get.width * 1.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                spreadRadius: 0,
                offset: const Offset(-6, 6),
              ),
            ],
          ),
        ),
        progressIndicatorBuilder: (context, url, progress) =>
            const LoaderWidget(),
        errorWidget: (context, url, error) => const LoaderWidget(),
      ),
    );
  }
}

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.width * 1.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(-6, 6),
          ),
        ],
      ),
    );
  }
}
