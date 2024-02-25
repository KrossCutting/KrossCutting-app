import 'package:flutter/material.dart';

Widget buildGreenGradientIconButton({
  required IconData icon,
  required double width,
  required double height,
  required double iconSize,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
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
      child: Material(
        type: MaterialType.transparency,
        shape: const CircleBorder(),
        child: Icon(
          icon,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    ),
  );
}
