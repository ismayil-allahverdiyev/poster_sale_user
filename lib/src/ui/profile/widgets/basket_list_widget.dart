import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/data/models/basket/basket_model.dart';
import 'package:poster_sale_user/src/data/models/poster/poster_model.dart';
import '../../../controllers/profile/profile_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/source/custom_divider.dart';
import '../../widgets/source/custom_shimmer_wrapper_widget.dart';
import 'profile_page_loader.dart';
import 'profile_product_widget.dart';

class BasketListWidget extends GetWidget<ProfileController> {
  const BasketListWidget({
    super.key,
    required this.basket,
  });

  final BasketModel basket;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileProductListTitle(
          date: basket.updated_at,
          state: basket.state,
        ),
        SizedBox(
          child: ListView.separated(
            itemCount: basket.items.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return ProfileProductWidget(
                basketItem: basket.items[index],
              );
            },
            separatorBuilder: (context, index) => const CustomDivider(),
          ),
        ),
      ],
    );
  }
}

class BasketListWidgetLoader extends GetWidget<ProfileController> {
  const BasketListWidgetLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [ProfileProductListTitleLoader(), ProfilePageLoader()],
    );
  }
}

class ProfileProductListTitle extends StatelessWidget {
  const ProfileProductListTitle(
      {super.key, required this.date, required this.state});

  final Timestamp date;
  final BasketState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            formatDate(date),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: lightGreyColor,
            ),
          ),
          const Spacer(),
          Text(
            state.name.capitalizeFirst ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: state == BasketState.ordered
                  ? Colors.yellow
                  : state == BasketState.canceled
                      ? redColor
                      : const Color(0xff61CA58),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileProductListTitleLoader extends StatelessWidget {
  const ProfileProductListTitleLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomShimmer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Container(
              width: Get.width * 0.3,
              height: 16,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Spacer(),
            Container(
              width: Get.width * 0.2,
              height: 16,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String formatDate(Timestamp date) {
  return '${date.toDate().day.toString().padLeft(2, '0')}.'
      '${date.toDate().month.toString().padLeft(2, '0')}.'
      '${date.toDate().year}';
}
