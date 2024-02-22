import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeButtonGreen extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HomeButtonGreen(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 140,
        height: 106,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(147, 70, 255, 1),
              Color.fromRGBO(90, 137, 231, 1),
              Color.fromRGBO(69, 226, 199, 1),
              Color.fromRGBO(180, 242, 136, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              type: MaterialType.transparency,
              shape: const CircleBorder(),
              child: Icon(
                icon,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              "Tutorial",
              style: TextStyle(
                fontFamily: "noteSans",
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
