import 'package:flutter/material.dart';

Widget buildGradientIconButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 50,
      height: 50,
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
          size: 30,
        ),
      ),
    ),
  );
}
