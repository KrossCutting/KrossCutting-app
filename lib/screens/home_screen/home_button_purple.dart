import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomeButtonPurple extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HomeButtonPurple(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          width: 140,
          height: 240,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedMeshGradient(
                  colors: const [
                    Color.fromRGBO(147, 70, 255, 1),
                    Color.fromRGBO(148, 95, 241, 1),
                    Color.fromRGBO(204, 204, 255, 1),
                    Color.fromRGBO(83, 183, 235, 1),
                  ],
                  options: AnimatedMeshGradientOptions(),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
            ],
          ),
        ),
      ),
    );
  }
}
