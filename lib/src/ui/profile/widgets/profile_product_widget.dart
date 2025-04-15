import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/poster/poster_model.dart';
import 'package:poster_sale_user/src/routes/app_routes.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_shimmer_wrapper_widget.dart';
import '../../../controllers/profile/profile_controller.dart';
import '../../theme/app_colors.dart';

class ProfileProductWidget extends GetWidget<ProfileController> {
  final PosterModel poster;
  const ProfileProductWidget({
    super.key,
    required this.poster,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: poster.images[0],
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
        progressIndicatorBuilder: (context, url, progress) =>
            const ProfileProductImageLoader(),
        errorWidget: (context, url, error) => const ProfileProductImageLoader(),
      ),
      trailing: Text(
        "${poster.price}\$",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: primaryColor,
          fontSize: 14,
        ),
      ),
      title: Text(
        poster.title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: lightBlueColor,
        ),
      ),
      subtitle: Text(
        poster.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      onTap: () {
        Get.toNamed(
          Routes.PRODUCT,
          parameters: {
            "id": poster.id,
          },
        );
      },
    );
  }
}

class ProfileProductImageLoader extends StatelessWidget {
  const ProfileProductImageLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: whiteColor,
        ),
      ),
    );
  }
}
