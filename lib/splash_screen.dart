import 'package:explore_coorg/home_page.dart';
import 'package:explore_coorg/screens/intro/intro_page_controller.dart';
import 'package:explore_coorg/services/preferences_service.dart';
import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();

    // ── Animations ───────────────────────────────────────
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeIn);

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));

    _animController.forward();

    // ── Navigate after delay ─────────────────────────────
    Future.delayed(const Duration(seconds: 10), () async {
      final hasSeenIntro = await PreferencesService.hasSeenIntro();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                hasSeenIntro ? const HomePage() : const IntroPageController(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background image ────────────────────────────
          Image.asset("assets/images/splash_bg.png", fit: BoxFit.cover),

          // ── Dark gradient overlay ────────────────────────
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.55),
                ],
              ),
            ),
          ),

          // ── Centered logo + title ────────────────────────
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // App icon / emblem
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.4),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.terrain_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // App name
                    Text(
                      "Coorg Explorer",
                      style: TextStyle(
                        fontSize: 38,
                        color: AppColors.backgroundLight,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        height: 1.1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Divider accent
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 32,
                          height: 1,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Discover the Scotland of India",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.backgroundLight.withOpacity(0.85),
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 32,
                          height: 1,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Bottom loader + tagline ──────────────────────
          Positioned(
            bottom: 52,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                children: [
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.accent,
                      ),
                      strokeWidth: 2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.explore_outlined,
                        size: 13,
                        color: AppColors.backgroundLight.withOpacity(0.6),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "Start your journey today",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.backgroundLight.withOpacity(0.6),
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
