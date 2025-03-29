import 'package:flutter/material.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';

class CustomTextButtonWidget extends StatelessWidget {
  const CustomTextButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.isDense = false,
  });
  final String title;
  final Function() onPressed;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        visualDensity: isDense ? VisualDensity.compact : null,
        overlayColor: WidgetStatePropertyAll(
          greyColor.withOpacity(0.1),
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
