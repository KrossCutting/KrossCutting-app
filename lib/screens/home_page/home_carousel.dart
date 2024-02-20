import 'package:flutter/material.dart';
import 'package:krosscutting_app/widgets/carousel_page.dart';

class HomeCarousel extends StatelessWidget {
  const HomeCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        CarouselPage(
          title: "Find StartTime (1/2)",
          description:
              "Slide the adjustment bar to set \nthe start time for the clip",
          imageAsset: "assets/images/home_screen_start.png",
        ),
        CarouselPage(
          title: "Select EditPoint (2/2)",
          description: "Select segments to include them \nin the trimmed video",
          imageAsset: "assets/images/home_screen_edit.png",
        ),
      ],
    );
  }
}
