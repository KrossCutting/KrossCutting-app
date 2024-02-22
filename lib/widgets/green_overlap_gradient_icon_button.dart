import 'package:flutter/material.dart';

Widget buildGreenOverlapGradientIconButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 80,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(180, 242, 136, 0.9),
                Color.fromRGBO(69, 226, 199, 0.9),
                Color.fromRGBO(12, 238, 236, 0.9),
                Color.fromRGBO(100, 153, 239, 0.9),
                Color.fromRGBO(179, 125, 235, 0.9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          width: 65,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(179, 125, 235, 0.9),
                Color.fromRGBO(100, 153, 239, 0.9),
                Color.fromRGBO(12, 238, 236, 0.9),
                Color.fromRGBO(69, 226, 199, 0.9),
                Color.fromRGBO(180, 242, 136, 0.9),
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
      ],
    ),
  );
}
