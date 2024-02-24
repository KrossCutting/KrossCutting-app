import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'package:krosscutting_app/provider/video_direction_provider.dart';
import 'package:krosscutting_app/constants/type.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_dotted.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_green.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_purple.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_peach.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoDirection = Provider.of<VideoDirectionProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            const Image(
              image: AssetImage("assets/images/logo_square.png"),
              height: 150,
            ),
            const SizedBox(
              height: 48,
            ),
            HomeButtonPeach(
              icon: Ionicons.phone_landscape_outline,
              onPressed: () {
                videoDirection.setVideoDirection(BUTTON_TYPE.HORIZONTAL);
                Navigator.pushNamed(context, "/album");
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeButtonPurple(
                  icon: Ionicons.phone_portrait_outline,
                  onPressed: () {
                    videoDirection.setVideoDirection(BUTTON_TYPE.VERTICAL);
                    Navigator.pushNamed(context, "/album");
                  },
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    HomeButtonGreen(
                      icon: Ionicons.sparkles_outline,
                      onPressed: () {
                        Navigator.pushNamed(context, "/instruction/fileUpload");
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const HomeButtonDotted(
                      icon: Ionicons.download_outline,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
