import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final Function()? onClick;

  const GradientButton({
    super.key,
    required this.buttonText,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: const LinearGradient(
              colors: [
                Colors.blue,
                Colors.purple,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 13,
            ),
            child: Text(
              buttonText,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.w600,
                fontFamily: "notoSansItalic",
              ),
            ),
          ),
        ),
        Positioned.fill(
          top: 0,
          left: 0,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(45),
              onTap: onClick,
            ),
          ),
        )
      ],
    );
  }
}
