import 'package:flutter/material.dart';
import 'package:krosscutting_app/screens/home_screen/home_screen.dart';

class InstructionCoachMark extends StatefulWidget {
  final VoidCallback onSkip;
  final List explainScreen;

  const InstructionCoachMark(
      {super.key, required this.onSkip, required this.explainScreen});

  @override
  State<InstructionCoachMark> createState() => _InstructionCoachMark();
}

class _InstructionCoachMark extends State<InstructionCoachMark> {
  int _currentIndex = 0;

  void _showNextContainer() {
    if (_currentIndex == widget.explainScreen.length - 1) {
      setState(() {
        widget.onSkip();
        return;
      });
    }

    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.explainScreen.length;
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
            child: widget.explainScreen[_currentIndex],
          ),
        ),
        Positioned(
          top: 40,
          left: 5,
          child: TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
                (route) => false,
              );
            },
            child: const Row(
              children: [
                Icon(
                  Icons.keyboard_double_arrow_left_sharp,
                  size: 36,
                  color: Colors.white,
                ),
                Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontFamily: "NoteSans",
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
