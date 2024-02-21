import 'package:flutter/material.dart';

Widget buildOverlapGradientIconButton({
  required IconData icon,
  required VoidCallback onPressed,
}) {
  return InkWell(
    onTap: onPressed,
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(83, 183, 235, 0.9),
                Color.fromRGBO(148, 95, 241, 0.9),
                Color.fromRGBO(173, 91, 223, 0.9),
                Color.fromRGBO(234, 101, 128, 0.9),
                Color.fromRGBO(242, 194, 125, 0.9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(242, 194, 125, 0.9),
                Color.fromRGBO(234, 101, 128, 0.9),
                Color.fromRGBO(173, 91, 223, 0.9),
                Color.fromRGBO(148, 95, 241, 0.9),
                Color.fromRGBO(83, 183, 235, 0.9),
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
