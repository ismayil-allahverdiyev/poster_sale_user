import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    super.key,
    required this.message,
    this.backgroundColor,
    this.textColor,
    this.onTap,
    this.width,
  });

  final String message;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: primaryColor,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              message,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor ?? textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
