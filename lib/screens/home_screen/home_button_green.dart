import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class HomeButtonGreen extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const HomeButtonGreen(
      {super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: SizedBox(
          width: 140,
          height: 106,
          child: Stack(
            children: [
              Positioned.fill(
                child: AnimatedMeshGradient(
                  colors: const [
                    Color.fromRGBO(147, 70, 255, 1),
                    Color.fromRGBO(90, 137, 231, 1),
                    Color.fromRGBO(69, 226, 199, 1),
                    Color.fromRGBO(180, 242, 136, 1),
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
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Tutorial",
                      style: TextStyle(
                        fontFamily: "noteSans",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white,
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
