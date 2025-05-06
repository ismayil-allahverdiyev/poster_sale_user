import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
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
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? minLength;
  final int? maxLines;
  final bool isRequired;
  final bool enabled;
  final Function(String)? onChanged;
  const CustomTextField({
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
    this.controller,
    this.keyboardType,
    this.maxLength,
    this.minLength,
    this.maxLines,
    this.isRequired = false,
    this.onChanged,
    this.enabled = true,
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
        maxLines: maxLines,
        enabled: enabled,
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
                    color: Color.fromARGB(255, 128, 128, 128),
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
          fillColor: fillColor ?? secondaryColor.withOpacity(0.2),
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
