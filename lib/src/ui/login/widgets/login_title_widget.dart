import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class LoginTitleWidget extends StatelessWidget {
  const LoginTitleWidget({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
          ),
          foregroundDecoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black,
                Colors.transparent,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0, 0.5],
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          child: Text(
            title,
            style: const TextStyle(
              color: whiteColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
