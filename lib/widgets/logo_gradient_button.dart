import 'package:flutter/material.dart';

Widget buildLogoGradientIconButton({
  required Image image,
  required double width,
  required double height,
  required VoidCallback onPressed,
}) {
  return InkWell(
    child: Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: width + 50,
          height: height + 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(242, 0, 245, 0.7),
                Color.fromRGBO(162, 38, 243, 0.7),
                Color.fromRGBO(142, 118, 243, 0.7),
                Color.fromRGBO(195, 190, 243, 0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Container(
          width: width + 25,
          height: height + 25,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
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
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
            child: image,
          ),
        ),
      ],
    ),
  );
}
