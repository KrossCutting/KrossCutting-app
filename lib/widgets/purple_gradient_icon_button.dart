import 'package:flutter/material.dart';

Widget buildPurpleGradientIconButton({
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
            Color.fromRGBO(242, 194, 125, 1),
            Color.fromRGBO(234, 101, 128, 1),
            Color.fromRGBO(148, 95, 241, 1),
            Color.fromRGBO(83, 183, 235, 1),
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
