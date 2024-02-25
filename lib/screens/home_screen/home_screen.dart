import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import 'package:krosscutting_app/constants/type.dart';
import 'package:krosscutting_app/provider/download_url_provider.dart';
import 'package:krosscutting_app/provider/video_direction_provider.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_dotted.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_green.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_purple.dart';
import 'package:krosscutting_app/screens/home_screen/home_button_peach.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoDirection = Provider.of<VideoDirectionProvider>(context);
    final downloadUrl = Provider.of<DownloadUrlProvider>(context).finalVideoUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: Image(
                  image: AssetImage("assets/images/white_logo_square.png"),
                  height: 150,
                ),
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
                          Navigator.pushNamed(
                              context, "/instruction/fileUpload");
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HomeButtonDotted(
                        onClick: downloadUrl == ""
                            ? () {}
                            : () =>
                                Navigator.pushNamed(context, "/downloadScreen"),
                        color: downloadUrl == ""
                            ? Colors.grey[800]!
                            : Colors.purpleAccent,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
