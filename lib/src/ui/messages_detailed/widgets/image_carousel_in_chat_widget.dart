import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/controllers/messages_detailed/messages_detailed_controller.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';
import '../../../constants/assets.dart';

class ImageCarouselInChatWidget extends GetWidget<MessagesDetailedController> {
  const ImageCarouselInChatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.8,
      width: Get.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: Get.width,
            height: Get.width * 0.4,
            decoration: const BoxDecoration(
              color: Color(0xffEAF8FF),
            ),
          ),
          SizedBox(
            height: Get.width * 0.8,
            width: Get.width,
            child: Obx(
              () {
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.poster.value?.images.length ?? 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? Get.width * 0.2 : 0,
                        right: index == 4 ? Get.width * 0.2 : 0,
                      ),
                      child: Obx(
                        () {
                          return controller.poster.value == null
                              ? const PosterImageLoader()
                              : CachedNetworkImage(
                                  imageUrl:
                                      controller.poster.value!.images[index],
                                  imageBuilder: (context, image) {
                                    return Container(
                                      height: Get.width * 0.5,
                                      width: Get.width * 0.45,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: image,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                    );
                                  },
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                          const PosterImageLoader(),
                                  errorWidget: (context, url, error) =>
                                      const PosterImageLoader(),
                                );
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: Get.width * 0.1,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PosterImageLoader extends StatelessWidget {
  const PosterImageLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        height: Get.width * 0.5,
        width: Get.width * 0.45,
        decoration: const BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
    );
  }
}
