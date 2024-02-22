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
        width: 140,
        height: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(83, 183, 235, 1),
              Color.fromRGBO(148, 95, 241, 1),
              Color.fromRGBO(204, 204, 255, 1),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
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
            const SizedBox(
              height: 16,
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
