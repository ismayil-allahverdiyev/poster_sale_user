import 'package:flutter/material.dart';

import '../../../constants/assets.dart';
import '../../theme/app_colors.dart';

class CustomDateSelector extends StatelessWidget {
  const CustomDateSelector({
    super.key,
    required this.hintText,
    this.value,
    required this.onTap,
  });

  final String hintText;
  final DateTime? value;
  final Function() onTap;

  String formatDateToDDMMYYYY(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} "
        "${date.month.toString().padLeft(2, '0')} "
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color.fromARGB(255, 128, 128, 128).withOpacity(0.5),
              width: 1.5,
              style: BorderStyle.solid,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: [
                Image.asset(
                  Assets.icon_calendar,
                  color: value == null ? lightBlueTextColor : textColor,
                  scale: 3,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  value == null ? hintText : formatDateToDDMMYYYY(value!),
                  style: TextStyle(
                    fontSize: 12,
                    color: value == null ? lightBlueTextColor : textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
