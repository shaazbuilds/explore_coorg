import 'package:explore_coorg/home_page.dart';
import 'package:explore_coorg/screens/intro/intro_page_four.dart';
import 'package:explore_coorg/screens/intro/intro_page_three.dart';
import 'package:explore_coorg/screens/intro/intro_screen_one.dart';
import 'package:explore_coorg/screens/intro/intro_screen_two.dart';
import 'package:explore_coorg/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPageController extends StatefulWidget {
  const IntroPageController({super.key});

  @override
  State<IntroPageController> createState() => _IntroPageControllerState();
}

class _IntroPageControllerState extends State<IntroPageController> {
  PageController pageController = PageController();
  String buttonText = "Skip";
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              currentPageIndex = index;
              if (index == 3) {
                buttonText = "Finish";
              } else {
                buttonText = "Skip";
              }
              setState(() {});
            },
            children: [
              IntroScreenOne(),
              IntroScreenTwo(),
              IntroPageThree(),
              IntroPageFour(),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: Text(buttonText),
                ),
                SmoothPageIndicator(controller: pageController, count: 4),
                currentPageIndex == 3
                    ? const Text("")
                    : GestureDetector(
                        onTap: () {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text("Next"),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
