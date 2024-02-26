import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:krosscutting_app/screens/instruction_page/instrunction_coach_mark.dart';
import 'package:krosscutting_app/widgets/moving_icon.dart';
import 'package:krosscutting_app/widgets/green_gradient_icon_button.dart';

class InstructionStartPoint extends StatelessWidget {
  final List _containers = [
    Center(
      child: Column(
        children: [
          const SizedBox(
            height: 478,
          ),
          const Text(
            "Tap the icon to select\nstart point for each clip",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Transform.translate(
            offset: const Offset(-43, 0),
            child: Column(
              children: [
                const MovingIcon(
                  isVertical: true,
                  icon: Icon(
                    Icons.arrow_circle_down_rounded,
                    size: 70,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildGreenGradientIconButton(
                  icon: Icons.cut_rounded,
                  width: 50,
                  height: 50,
                  iconSize: 30,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    const Center(
      child: Column(
        children: [
          SizedBox(
            height: 250,
          ),
          Column(
            children: [
              MovingIcon(
                isVertical: false,
                icon: Icon(
                  Icons.swipe_left_rounded,
                  size: 90,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Text(
            "Swipe the widget to\nproceed to the next clip",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
    const Column(
      children: [
        SizedBox(
          height: 51,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MovingIcon(
              isVertical: false,
              icon: Icon(
                Icons.arrow_circle_right_outlined,
                size: 70,
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Icon(
              Icons.arrow_forward_rounded,
            ),
            SizedBox(
              width: 12,
            ),
          ],
        ),
        SizedBox(
          height: 80,
        ),
        Text(
          "Tap the icon to move\nedit point selection page",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontFamily: "noteSans",
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          "The icon will appear\nonce a start point is selected\nfrom all the clips.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: "noteSans",
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ];
  InstructionStartPoint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/images/startPoint_demo.png"),
              ),
            ),
            InstructionCoachMark(
              onSkip: () {
                Navigator.pushNamed(
                  context,
                  "/instruction/editPoint",
                );
              },
              explainScreen: _containers,
            ),
          ],
        ),
      ),
    );
  }
}
