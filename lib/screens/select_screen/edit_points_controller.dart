import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:krosscutting_app/screens/progress_screen.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';
import 'package:krosscutting_app/widgets/purple_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/purple_overlap_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/green_overlap_gradient_icon_button.dart';
import 'package:krosscutting_app/screens/select_screen/custom_video_progress_indicator.dart';

class VideoControllerPage extends StatefulWidget {
  final int index;
  const VideoControllerPage({super.key, required this.index});

  @override
  _VideoControllerPageState createState() => _VideoControllerPageState();
}

class _VideoControllerPageState extends State<VideoControllerPage> {
  @override
  Widget build(BuildContext context) {
    final videoManager = Provider.of<VideoManager>(context);
    final controller = videoManager.controllers[widget.index];
    final isLastVideo =
        videoManager.currentIndex == videoManager.controllers.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Chewie(
            controller: ChewieController(
              videoPlayerController: controller,
              autoPlay: false,
              looping: false,
              showControls: false,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 40,
              ),
              child: Row(
                children: [
                  buildPurpleOverlapGradientIconButton(
                    icon: Icons.arrow_back_rounded,
                    onPressed: () {
                      videoManager.setEditPage(false);
                      Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  GradientText(
                    videoManager.currentTitle,
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: "lobster",
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 1.0,
                          offset: Offset(0.1, 2.0),
                        )
                      ],
                    ),
                    colors: const [
                      Color.fromRGBO(83, 183, 235, 1),
                      Color.fromRGBO(148, 95, 241, 1),
                      Color.fromRGBO(162, 38, 243, 1),
                      Color.fromRGBO(234, 101, 128, 1),
                      Color.fromRGBO(242, 194, 125, 1),
                    ],
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  if (isLastVideo)
                    buildGreenOverlapGradientIconButton(
                      icon: Icons.arrow_forward_rounded,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProgressScreen(),
                          ),
                          (route) => false,
                        );
                      },
                    )
                  else
                    const SizedBox(width: 60),
                ],
              ),
            ),
          ),
          _buildCustomController(context, controller, videoManager),
        ],
      ),
    );
  }

  Widget _buildCustomController(BuildContext context,
      VideoPlayerController controller, VideoManager videoManager) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: CustomVideoProgressIndicator(
                  controller: controller,
                  markers: videoManager.editPoints[videoManager.currentIndex],
                  onMarkerTap: (Duration position) {
                    controller.seekTo(position);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.replay_5_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                    onPressed: () {
                      controller.seekTo(controller.value.position -
                          const Duration(seconds: 5));
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        if (controller.value.isPlaying) {
                          controller.pause();
                        } else {
                          controller.play();
                        }
                      });
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.forward_5_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                    onPressed: () {
                      controller.seekTo(controller.value.position +
                          const Duration(seconds: 5));
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 25.0,
              ),
              Wrap(
                spacing: 40.0,
                alignment: WrapAlignment.center,
                children: [
                  buildPurpleGradientIconButton(
                    icon: Icons.auto_fix_high,
                    onPressed: () {
                      final currentPosition = controller.value.position;

                      videoManager.addMarker(currentPosition);
                    },
                  ),
                  buildPurpleGradientIconButton(
                    icon: Icons.restore,
                    onPressed: () {
                      videoManager.resetMarkerList();
                    },
                  ),
                  buildPurpleGradientIconButton(
                    icon: Icons.highlight_remove,
                    onPressed: () {
                      videoManager.deleteMarker(controller);
                    },
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
