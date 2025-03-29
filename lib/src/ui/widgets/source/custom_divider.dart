import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Divider(
      thickness: 1,
      height: 1,
      indent: 16,
      endIndent: 16,
      color: lightBlueTextColor,
    );
  }
}
