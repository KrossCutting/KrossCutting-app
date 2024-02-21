import 'package:flutter/material.dart';

Widget buildLogoGradientIconButton({
  required Image logo,
  required VoidCallback onPressed,
}) {
  return InkWell(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(242, 0, 245, 0.9),
                Color.fromRGBO(162, 38, 243, 0.9),
                Color.fromRGBO(142, 118, 243, 0.9),
                Color.fromRGBO(195, 190, 243, 0.9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: const LinearGradient(
              colors: [
                Color.fromRGBO(195, 190, 243, 0.9),
                Color.fromRGBO(142, 118, 243, 0.9),
                Color.fromRGBO(162, 38, 243, 0.9),
                Color.fromRGBO(242, 0, 245, 0.9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Material(
              type: MaterialType.transparency,
              shape: const CircleBorder(),
              child: logo),
        ),
      ],
    ),
  );
}
