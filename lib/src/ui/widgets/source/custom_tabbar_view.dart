import 'package:flutter/material.dart';

import '../../../constants/assets.dart';

class CustomTabBarView extends StatelessWidget {
  const CustomTabBarView({
    super.key,
    required this.tabController,
    required this.widgets,
    this.animate,
    required this.height,
    this.width,
    this.hasControlledAnimation = false,
    this.isScrollable = true,
  });

  final TabController? tabController;
  final List<Widget> widgets;
  final Function({required bool isRight})? animate;
  final double? height;
  final double? width;
  final bool hasControlledAnimation;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: height,
          width: width,
          child: TabBarView(
            controller: tabController,
            physics: isScrollable
                ? const BouncingScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            children: widgets,
          ),
        ),
        Positioned(
          right: 2,
          child: !hasControlledAnimation
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    if (animate != null) animate!(isRight: true);
                  },
                  child: Image.asset(
                    Assets.icon_right,
                    scale: 2,
                  ),
                ),
        ),
        Positioned(
          left: 2,
          child: !hasControlledAnimation
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    if (animate != null) animate!(isRight: false);
                  },
                  child: Image.asset(
                    Assets.icon_left,
                    scale: 3,
                  ),
                ),
        ),
      ],
    );
  }
}
