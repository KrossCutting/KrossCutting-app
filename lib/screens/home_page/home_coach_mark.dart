import 'package:flutter/material.dart';
import 'package:krosscutting_app/constants/button_type.dart';
import 'package:krosscutting_app/screens/home_page/home_button.dart';
import 'package:krosscutting_app/widgets/moving_icon.dart';

class HomeCoachMark extends StatefulWidget {
  final VoidCallback onSkip;

  const HomeCoachMark({super.key, required this.onSkip});

  @override
  State<HomeCoachMark> createState() => _HomeCoachMarkState();
}

class _HomeCoachMarkState extends State<HomeCoachMark> {
  int _currentIndex = 0;

  final List _containers = [
    Transform.translate(
      offset: const Offset(0, -60),
      child: const Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MovingIcon(
              isVertical: false,
              icon: Icon(
                Icons.swipe_left,
                size: 100,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Slide the widget \n to view instructions",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: "notoSans",
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    ),
    Center(
      child: Transform.translate(
        offset: const Offset(0, 80),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 85,
            ),
            Text(
              "Tap 'Vertical' to combine \nthree vertical videos into \na single vertical trim",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: "notoSans",
                fontWeight: FontWeight.w600,
              ),
            ),
            MovingIcon(
              isVertical: true,
              icon: Icon(
                Icons.arrow_downward_rounded,
                size: 120,
                color: Colors.white,
              ),
            ),
            HomeButton(
              buttonText: "Vertical",
              colorStyle: "purple",
              isCoachMark: true,
              type: ButtonType.vertical,
            ),
          ],
        ),
      ),
    ),
    Center(
      child: Transform.translate(
        offset: const Offset(0, 210),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 110,
            ),
            Text(
              "Tap 'Horizontal' to combine \nthree horizontal videos into \na single horizontal trim",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: "notoSans",
                fontWeight: FontWeight.w600,
              ),
            ),
            MovingIcon(
              isVertical: true,
              icon: Icon(
                Icons.arrow_downward_rounded,
                size: 120,
                color: Colors.white,
              ),
            ),
            HomeButton(
              buttonText: "Horizontal",
              colorStyle: "yellow",
              isCoachMark: true,
              type: ButtonType.horizontal,
            ),
          ],
        ),
      ),
    ),
  ];

  void _showNextContainer() {
    if (_currentIndex == _containers.length - 1) {
      setState(() {
        widget.onSkip();
        return;
      });
    }

    setState(() {
      _currentIndex = (_currentIndex + 1) % _containers.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _showNextContainer,
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: _containers[_currentIndex],
          ),
        ),
        Positioned(
          top: 60,
          left: 24,
          child: TextButton(
            onPressed: () {
              widget.onSkip();
            },
            child: const Row(
              children: [
                Icon(
                  Icons.keyboard_double_arrow_left_sharp,
                  size: 36,
                  color: Colors.white,
                ),
                Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "notoSans",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
