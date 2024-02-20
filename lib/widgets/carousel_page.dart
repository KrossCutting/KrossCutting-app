import 'package:flutter/material.dart';

class CarouselPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageAsset;

  const CarouselPage({
    super.key,
    required this.title,
    required this.description,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(43, 37, 67, 0.7),
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: "noteSansItalic",
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(imageAsset),
          const SizedBox(height: 40),
          Image.asset("assets/images/home_screen_frames.png"),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "noteSans",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
