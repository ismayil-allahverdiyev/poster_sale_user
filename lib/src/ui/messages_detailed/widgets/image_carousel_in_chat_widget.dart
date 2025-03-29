import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/assets.dart';

class ImageCarouselInChatWidget extends StatelessWidget {
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
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? Get.width * 0.2 : 0,
                    right: index == 4 ? Get.width * 0.2 : 0,
                  ),
                  child: Container(
                    height: Get.width * 0.5,
                    width: Get.width * 0.45,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.test_image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: Get.width * 0.1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
