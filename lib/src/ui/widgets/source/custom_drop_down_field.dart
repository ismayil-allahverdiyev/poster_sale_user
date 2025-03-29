import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poster_sale_user/src/constants/assets.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';

class CustomDropDownField extends StatelessWidget {
  final bool isRounded;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final Color? fillColor;
  final bool hasBorder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasPadding;
  final FocusNode? focusNode;
  final List<DropdownMenuItem> items;
  final Function(dynamic)? onChanged;
  const CustomDropDownField({
    super.key,
    this.isRounded = false,
    this.hintText,
    this.hintStyle,
    this.borderRadius,
    this.fillColor,
    this.hasBorder = false,
    this.prefixIcon,
    this.suffixIcon,
    this.hasPadding = true,
    this.focusNode,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hasPadding
          ? const EdgeInsets.symmetric(horizontal: 8.0)
          : EdgeInsets.zero,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        items: items,
        onChanged: onChanged,
        focusColor: whiteColor,
        dropdownColor: whiteColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ??
              const TextStyle(
                color: lightBlueTextColor,
              ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isRounded ? 1000 : borderRadius ?? 8,
            ),
            borderSide: hasBorder
                ? BorderSide(
                    color: const Color.fromARGB(255, 128, 128, 128)
                        .withOpacity(0.5),
                    width: 1.5,
                    style: BorderStyle.solid,
                  )
                : BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isRounded ? 1000 : borderRadius ?? 8,
            ),
            borderSide: hasBorder
                ? BorderSide(
                    color: const Color.fromARGB(255, 128, 128, 128)
                        .withOpacity(0.5),
                    width: 1.5,
                    style: BorderStyle.solid,
                  )
                : BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              isRounded ? 1000 : borderRadius ?? 8,
            ),
            borderSide: hasBorder
                ? BorderSide(
                    color: const Color.fromARGB(255, 128, 128, 128)
                        .withOpacity(0.5),
                    width: 1.5,
                    style: BorderStyle.solid,
                  )
                : BorderSide.none,
          ),
          fillColor: fillColor ?? whiteColor,
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
