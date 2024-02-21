import 'package:flutter/material.dart';
import 'package:krosscutting_app/screens/home_screen/home_button.dart';
import 'package:krosscutting_app/screens/home_screen/home_carousel.dart';
import 'package:krosscutting_app/screens/home_screen/home_coach_mark.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isCoachMarkDisplayed = true;

  void hideCoachMark() {
    setState(() {
      _isCoachMarkDisplayed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                Expanded(
                  child: Stack(
                    children: [
                      const HomeCarousel(),
                      Transform.translate(
                        offset: const Offset(0, -60),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Transform.translate(
                                  offset: const Offset(40, 20),
                                  child: const Text(
                                    "How to kross-cut",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40,
                                        fontFamily: "lobster"),
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(10, 20),
                                  child: SizedBox(
                                    width: 45,
                                    child: Image.asset(
                                        "assets/images/icon_logo_mini.png"),
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
                const SizedBox(
                  height: 80,
                ),
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: const Column(
                    children: [
                      HomeButton(
                        buttonText: "Vertical",
                        colorStyle: "purple",
                        isCoachMark: false,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      HomeButton(
                        buttonText: "Horizontal",
                        colorStyle: "yellow",
                        isCoachMark: false,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isCoachMarkDisplayed)
            HomeCoachMark(
              onSkip: hideCoachMark,
            ),
        ],
      ),
    );
  }
}
