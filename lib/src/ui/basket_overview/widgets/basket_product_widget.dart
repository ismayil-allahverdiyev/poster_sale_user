import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_icon_button.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';

class BasketProductWidget extends StatelessWidget {
  const BasketProductWidget({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: const DecorationImage(
            image: AssetImage(Assets.test_image),
            fit: BoxFit.cover,
          ),
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "200\$",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          CustomIconButton(
            assetPath: Assets.icon_trash,
            onTap: () {},
          )
        ],
      ),
      title: Text(
        "15th October, 2024, 12:37 pm $index",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: lightBlueColor,
        ),
      ),
      subtitle: Text(
        "Requested by: someemail@gmail.com $index",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () {},
    );
  }
}
