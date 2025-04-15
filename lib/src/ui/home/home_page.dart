import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:poster_sale_user/src/constants/assets.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_icon_button.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_scaffold.dart';
import 'package:poster_sale_user/src/ui/widgets/source/custom_text_field.dart';
import '../../controllers/home/home_controller.dart';
import '../widgets/poster_animated_widget.dart';
import 'widgets/category_selection_widget.dart';
import 'widgets/most_viewed_title_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return CustomScaffold(
          padding: EdgeInsets.zero,
          hasAppBar:
              !controller.isFocused.value && !controller.isSearchIsOn.value,
          children: [
            Obx(
              () {
                return SizedBox(
                  height: controller.isFocused.value ||
                          controller.isSearchIsOn.value
                      ? 32
                      : 0,
                );
              },
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomSearchField(),
                  const CategorySelectionWidget(),
                  Obx(() {
                    return controller.isFocused.value ||
                            controller.isSearchIsOn.value
                        ? Obx(
                            () {
                              return ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return PosterWidget(
                                    poster: controller.foundPosters[index],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 16,
                                  );
                                },
                                itemCount: controller.foundPosters.length,
                              );
                            },
                          )
                        : const Column(
                            children: [
                              MostViewedTitle(),
                              SizedBox(
                                height: 16,
                              ),
                              PosterAnimatedWidget(),
                            ],
                          );
                  }),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class CustomSearchField extends GetWidget<HomeController> {
  const CustomSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Obx(
          () {
            return controller.isFocused.value || controller.isSearchIsOn.value
                ? Row(
                    children: [
                      const SizedBox(
                        width: 8,
                      ),
                      CustomIconButton(
                        assetPath: Assets.icon_arrow_left,
                        onTap: () {
                          controller.clearSearch();
                        },
                      ),
                    ],
                  )
                : const SizedBox();
          },
        ),
        Expanded(
          child: CustomTextField(
            isRounded: true,
            hintText: "Search for a poster",
            onChanged: (value) => controller.searchPosters(),
            focusNode: controller.searchFocusNode,
            controller: controller.searchController,
            prefixIcon: Image.asset(
              Assets.icon_search,
              scale: 3,
            ),
          ),
        ),
      ],
    );
  }
}
