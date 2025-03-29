import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../theme/app_colors.dart';

class CustomSmoothIndicator extends StatelessWidget {
  const CustomSmoothIndicator({
    super.key,
    required this.selectedIndex,
    required this.count,
    required this.onDotClicked,
    this.isExpanding = false,
  });

  final int selectedIndex;
  final int count;
  final Function(int) onDotClicked;
  final bool isExpanding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSmoothIndicator(
        activeIndex: selectedIndex,
        count: count,
        onDotClicked: onDotClicked,
        effect: _getIndicatorEffect(isExpanding),
      ),
    );
  }
}

IndicatorEffect _getIndicatorEffect(bool isExpanding) {
  return isExpanding
      ? ExpandingDotsEffect(
          spacing: 6.0,
          radius: 4.0,
          dotWidth: 16.0,
          dotHeight: 8.0,
          expansionFactor: 3.5,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          dotColor: Colors.grey.shade300,
          activeDotColor: lightBlueColor,
        )
      : WormEffect(
          spacing: 6.0,
          radius: 4.0,
          dotWidth: 8.0,
          dotHeight: 8.0,
          paintStyle: PaintingStyle.fill,
          strokeWidth: 1.5,
          dotColor: Colors.grey.shade300,
          activeDotColor: lightBlueColor,
        );
}
