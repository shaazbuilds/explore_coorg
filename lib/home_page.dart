import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
        child: Image.asset("assets/images/logo_nobg.png", fit: BoxFit.contain),
      ),
    );
  }
}
