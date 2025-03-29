import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';

class BasketOverviewWidget extends StatelessWidget {
  const BasketOverviewWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: greyColor.withOpacity(0.3),
        child: Image.asset(
          Assets.icon_profile,
          scale: 2.5,
        ),
      ),
      trailing: Padding(
        padding: EdgeInsets.only(
          left: Get.width * 0.05,
          right: Get.width * 0.025,
        ),
        child: Text(
          "200\$",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: index % 2 == 0 ? null : FontWeight.bold,
            color: index % 2 == 0 ? textColor : primaryColor,
          ),
        ),
      ),
      title: Text(
        "15th October, 2024, 12:37 pm $index",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: index % 2 == 0 ? null : FontWeight.bold,
          color: index % 2 == 0 ? lightBlueTextColor : lightBlueColor,
        ),
      ),
      subtitle: Text(
        "Requested by: someemail@gmail.com $index",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontWeight: index % 2 == 0 ? null : FontWeight.bold,
          color: index % 2 == 0 ? textColor : primaryColor,
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () {},
    );
  }
}
