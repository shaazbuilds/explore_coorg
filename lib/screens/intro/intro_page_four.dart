import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IntroPageFour extends StatelessWidget {
  const IntroPageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/screen_four.png"),
        SizedBox(height: 40),
        Text(
          "Seek Culture & Nature with Explorer",
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
            "Navigate from iconic landmarks to local heritage sites. Immerse yourself in the vibrant culture and nature that defines Coorg's unique charm.",
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
