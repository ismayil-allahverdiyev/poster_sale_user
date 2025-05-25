import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_item_model.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_icon_button.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';

import '../../../constants/assets.dart';
import '../../../routes/app_routes.dart';
import '../../theme/app_colors.dart';

class BasketProductWidget extends StatelessWidget {
  const BasketProductWidget({
    super.key,
    required this.basketItem,
  });

  final BasketItemModel basketItem;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.toNamed(
        Routes.PRODUCT,
        parameters: {
          "id": basketItem.id,
        },
      ),
      leading: CachedNetworkImage(
        imageUrl: basketItem.image,
        imageBuilder: (context, imageProvider) => Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const ImageLoader(),
        errorWidget: (context, url, error) => const ImageLoader(),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${basketItem.addedPrice}\$",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
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
        basketItem.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: lightBlueColor,
        ),
      ),
      subtitle: Text(
        basketItem.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }
}

class BasketProductWidgetLoader extends StatelessWidget {
  const BasketProductWidgetLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: ListTile(
        leading: const ImageLoader(),
        title: Container(
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
        ),
        subtitle: Container(
          height: 12,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white,
          ),
        ),
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 24),
        onTap: () {},
      ),
    );
  }
}

class ImageLoader extends StatelessWidget {
  const ImageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey.shade300,
        ),
      ),
    );
  }
}
