import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IntroScreenTwo extends StatelessWidget {
  const IntroScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/screen_two.png"),
        SizedBox(height: 40),
        Text(
          "Experience Misty Hills & Waterfalls",
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
            "Explore lush green coffee plantations. Witness the beauty of hidden, cascading waterfalls. Feel the pure mist of the unique Coorg Explorer trails.",
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
