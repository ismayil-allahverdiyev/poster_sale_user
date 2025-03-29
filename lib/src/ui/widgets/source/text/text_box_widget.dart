import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../theme/app_colors.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.index,
    required this.text,
  });

  final int index;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: (index % 2 == 0)
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Container(
              constraints: BoxConstraints(maxWidth: Get.width * 0.75),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (index % 2 == 0) ? primaryColor : lightGreyColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(8),
                  bottomRight: const Radius.circular(8),
                  topLeft: (index % 2 == 0)
                      ? const Radius.circular(8)
                      : const Radius.circular(0),
                  topRight: (index % 2 == 0)
                      ? const Radius.circular(0)
                      : const Radius.circular(8),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: (index % 2 == 0) ? whiteColor : primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
