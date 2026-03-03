import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/logo.png"),
        SizedBox(height: 40),
        Text(
          "We Need To Work Hard",
          style: TextStyle(
            color: AppColors.backgroundDark,
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 40),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "We Need To Work Hard We Need To Work Hard We Need To Work Hard We Need To Work Hard We Need To Work Hard",
            style: TextStyle(
              color: AppColors.backgroundDark.withOpacity(0.6),
              fontSize: 16,
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
