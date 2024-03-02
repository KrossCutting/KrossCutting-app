import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:krosscutting_app/screens/instruction_page/instrunction_coach_mark.dart';
import 'package:krosscutting_app/widgets/moving_icon.dart';
import 'package:krosscutting_app/widgets/purple_gradient_icon_button.dart';

class InstructionEditPoint extends StatelessWidget {
  const InstructionEditPoint({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    final List containers = [
      Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.485,
            ),
            Text(
              "Each crosscut point you select\nwill be highlighted for 3 seconds",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.043,
                fontFamily: "noteSans",
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Text(
              "Tap the icon to choose\nthe clip's crosscut point(s)",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.07,
                fontFamily: "noteSans",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.075,
            ),
            Transform.translate(
              offset: Offset(screenWidth * -0.24, 0),
              child: Column(
                children: [
                  MovingIcon(
                    isVertical: true,
                    icon: Icon(
                      Icons.arrow_circle_down_rounded,
                      size: screenHeight * 0.082,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.024,
                  ),
                  buildPurpleGradientIconButton(
                    icon: Icons.cut_rounded,
                    width: screenHeight * 0.06,
                    height: screenHeight * 0.06,
                    iconSize: 30,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.535,
            ),
            Text(
              "You can navigate\nto the crosscut point by tapping on the triangle",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.0635,
                fontFamily: "noteSans",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            Stack(
              children: [
                Container(
                  height: 3,
                  width: screenWidth * 0.8,
                  color: Colors.grey,
                ),
                Container(
                  height: 3,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 98,
                ),
                SizedBox(
                  width: 15,
                  height: 15,
                  child: CustomPaint(
                    painter: TrianglePainter(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  width: 68,
                ),
                SizedBox(
                  width: 15,
                  height: 15,
                  child: CustomPaint(
                    painter: TrianglePainter(color: Colors.red),
                  ),
                )
              ],
            )
          ],
        ),
      ),
      Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.58,
            ),
            Text(
              "To remove a crosscut\npoint, tap on the icon",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth * 0.06,
                fontFamily: "noteSans",
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.041,
            ),
            Stack(
              children: [
                Container(
                  height: 3,
                  width: screenWidth * 0.8,
                  color: Colors.grey,
                ),
                Container(
                  height: 3,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.red[900],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 98,
                ),
                SizedBox(
                  width: 15,
                  height: 15,
                  child: CustomPaint(
                    painter: TrianglePainter(color: Colors.red),
                  ),
                ),
                const SizedBox(
                  width: 68,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.117,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MovingIcon(
                  isVertical: false,
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: screenHeight * 0.082,
                  ),
                ),
                const SizedBox(
                  width: 39,
                ),
                buildPurpleGradientIconButton(
                  icon: Icons.highlight_remove,
                  width: screenHeight * 0.06,
                  height: screenHeight * 0.06,
                  iconSize: 30,
                  onPressed: () {},
                ),
                SizedBox(
                  width: screenWidth * 0.2,
                ),
              ],
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/images/editPoint_demo.png"),
              ),
            ),
            InstructionCoachMark(
                onSkip: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName("/home"),
                  );
                },
                explainScreen: containers),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final Paint _paint;

  TrianglePainter({required this.color}) : _paint = Paint()..color = color;

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
