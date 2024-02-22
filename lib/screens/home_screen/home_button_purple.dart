import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeButtonPurple extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HomeButtonPurple(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 300,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
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
                size: 50,
              ),
            ),
            const Text(
              "9 : 16",
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
