import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IntroPageThree extends StatelessWidget {
  const IntroPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/screen_three.png"),
        SizedBox(height: 40),
        Text(
          "Follow the Path of Rivers and Roads",
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
            "Discover winding rivers and ancient trails that lead to adventure. Coorg Explorer is your guide to mapping out the ultimate wilderness experience.",
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
