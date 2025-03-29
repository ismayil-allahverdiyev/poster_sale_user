import 'package:flutter/material.dart';
import 'package:poster_sale_user/src/ui/theme/app_colors.dart';

class BasketsOverviewAppBar extends StatelessWidget {
  const BasketsOverviewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Requests",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: primaryColor),
          )
        ],
      ),
    );
  }
}
