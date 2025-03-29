import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/assets.dart';
import '../../../routes/app_routes.dart';
import '../../theme/app_colors.dart';

class ProfileUserInfoTile extends StatelessWidget {
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
      title: const Text(
        'someemail@gmail.com',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
      subtitle: const Text(
        '15.06.2024',
        style: TextStyle(
          fontSize: 14,
        ),
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
