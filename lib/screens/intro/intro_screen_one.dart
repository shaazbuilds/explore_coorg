import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IntroScreenOne extends StatelessWidget {
  const IntroScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/screen_one.png"),
        SizedBox(height: 40),
        Text(
          "The Journey Begins in Coorg",
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
            "Embark on your adventure with Coorg Explorer. Locate the heart of this stunning hill station and unlock the secrets of its landscapes",
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
