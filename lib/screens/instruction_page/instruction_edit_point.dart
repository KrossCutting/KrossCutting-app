import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:krosscutting_app/screens/instruction_page/instrunction_coach_mark.dart';
import 'package:krosscutting_app/widgets/moving_icon.dart';
import 'package:krosscutting_app/widgets/purple_gradient_icon_button.dart';

class InstructionEditPoint extends StatelessWidget {
  final List _containers = [
    Center(
      child: Column(
        children: [
          const SizedBox(
            height: 334,
          ),
          const Text(
            "Each crosscut point you select\nwill be highlighted for 3 seconds",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Tap the icon to choose\nthe clip's crosscut point(s)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          Transform.translate(
            offset: const Offset(-90, 0),
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
                buildPurpleGradientIconButton(
                  icon: Icons.auto_fix_high,
                  width: 35,
                  height: 35,
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
          const SizedBox(
            height: 395,
          ),
          const Text(
            "You can navigate\nto the crosscut point by tapping on the triangle",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Stack(
            children: [
              Container(
                height: 3,
                width: 360,
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
          const SizedBox(
            height: 434,
          ),
          const Text(
            "To remove a crosscut\npoint, tap on the icon",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Stack(
            children: [
              Container(
                height: 3,
                width: 360,
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
          const SizedBox(
            height: 96,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const MovingIcon(
                isVertical: false,
                icon: Icon(
                  Icons.arrow_circle_right_outlined,
                  size: 70,
                ),
              ),
              const SizedBox(
                width: 39,
              ),
              buildPurpleGradientIconButton(
                icon: Icons.highlight_remove,
                width: 35,
                height: 35,
                iconSize: 30,
                onPressed: () {},
              ),
              const SizedBox(
                width: 80,
              ),
            ],
          ),
        ],
      ),
    ),
  ];
  InstructionEditPoint({super.key});

  @override
  Widget build(BuildContext context) {
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
                    ModalRoute.withName('/home'),
                  );
                },
                explainScreen: _containers),
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
