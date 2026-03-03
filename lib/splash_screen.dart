import 'package:explore_coorg/home_page.dart';
import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // ── Centered title content ──────────────────────
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Coorg Explorer",
                    style: TextStyle(
                      fontSize: 60,
                      color: AppColors.backgroundLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Discover the Scotland of India",
                    style: TextStyle(
                      fontSize: 24,
                      color: AppColors.backgroundLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // ── Bottom: loader + tagline ────────────────────
            Positioned(
              bottom: 52,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.accent, // your electric green
                    ),
                    strokeWidth: 2.5,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.explore_outlined,
                        size: 15,
                        color: AppColors.backgroundLight.withOpacity(0.7),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Start your journey today",
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.backgroundLight.withOpacity(0.7),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
