import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile/profile_controller.dart';
import '../../theme/app_colors.dart';
import '../../widgets/source/custom_divider.dart';
import 'profile_page_loader.dart';
import 'profile_product_widget.dart';

class BasketListWidget extends GetWidget<ProfileController> {
  const BasketListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileProductListTitle(
          date: DateTime.now(),
          state: StateOfProductList.Successfull,
        ),
        SizedBox(
          child: Obx(
            () {
              return !controller.isLoaded.value
                  ? const ProfilePageLoader()
                  : ListView.separated(
                      itemCount: controller.myPosters.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return ProfileProductWidget(
                          poster: controller.myPosters[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const CustomDivider(),
                    );
            },
          ),
        ),
      ],
    );
  }
}

enum StateOfProductList { Successfull, Waiting, Cancelled }

class ProfileProductListTitle extends StatelessWidget {
  const ProfileProductListTitle(
      {super.key, required this.date, required this.state});

  final DateTime date;
  final StateOfProductList state;

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
            state.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: state == StateOfProductList.Waiting
                  ? Colors.yellow
                  : state == StateOfProductList.Cancelled
                      ? redColor
                      : const Color(0xff61CA58),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}.'
      '${date.month.toString().padLeft(2, '0')}.'
      '${date.year}';
}
