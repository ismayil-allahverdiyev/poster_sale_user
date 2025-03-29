import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.assetPath,
    required this.onTap,
    this.scale,
    this.height,
  });
  final String assetPath;
  final double? scale;
  final Function() onTap;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        assetPath,
        scale: scale ?? 3,
        height: height,
      ),
    );
  }
}
