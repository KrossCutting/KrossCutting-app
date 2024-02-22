import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dotted_border/dotted_border.dart';

class HomeButtonDotted extends StatelessWidget {
  final IconData icon;

  const HomeButtonDotted({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: Colors.white,
      borderType: BorderType.RRect,
      radius: const Radius.circular(24),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(24),
        ),
        child: Container(
          width: 140,
          height: 110,
          color: const Color(0xFF181818),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 52,
                color: Colors.grey[800],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
