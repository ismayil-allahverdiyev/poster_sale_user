import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poster_sale_user/src/constants/assets.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';

class CustomSimpleTextField extends StatelessWidget {
  final bool isRounded;
  final String? hintText;
  final TextStyle? hintStyle;
  final double? borderRadius;
  final Color fillColor;
  final bool hasBorder;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool hasPadding;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLength;
  final int? maxLines;
  final bool isRequired;
  final Function(String)? onChanged;
  final bool isObscure;
  const CustomSimpleTextField({
    super.key,
    this.isRounded = false,
    this.hintText,
    this.hintStyle,
    this.borderRadius,
    this.fillColor = Colors.transparent,
    this.hasBorder = true,
    this.prefixIcon,
    this.suffixIcon,
    this.hasPadding = true,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.minLength,
    this.maxLines,
    this.isRequired = false,
    this.onChanged,
    this.isObscure = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: hasPadding
          ? const EdgeInsets.symmetric(horizontal: 8.0)
          : EdgeInsets.zero,
      child: TextFormField(
        onChanged: onChanged,
        focusNode: focusNode,
        controller: controller,
        cursorColor: primaryColor,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.none,
        maxLines: !isObscure ? 1 : maxLines,
        obscureText: !isObscure,
        validator: (value) {
          if (isRequired && value!.isEmpty) {
            return "This field is required";
          } else if (minLength != null && value!.length < minLength!) {
            return "This field must be at least 3 characters";
          } else if (maxLength != null && value!.length > maxLength!) {
            return "This field must be at most 50 characters";
          }
          return null;
        },
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
                ? const BorderSide(
                    color: lightBlueTextColor,
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
                ? const BorderSide(
                    color: Color(0xffCBD4D6),
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
                ? const BorderSide(
                    color: Color(0xffCBD4D6),
                    width: 1.5,
                    style: BorderStyle.solid,
                  )
                : BorderSide.none,
          ),
          fillColor: fillColor,
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
