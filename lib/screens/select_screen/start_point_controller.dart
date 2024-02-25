import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:krosscutting_app/screens/select_screen/custom_video_progress_indicator.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';
import 'package:krosscutting_app/widgets/green_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/green_overlap_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/purple_overlap_gradient_icon_button.dart';

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
    final isStartPointsAllSelected =
        videoManager.startPoints.every((marker) => marker.length == 1);

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
                  buildGreenOverlapGradientIconButton(
                      icon: Icons.arrow_back_rounded,
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  const Spacer(),
                  GradientText(
                    videoManager.currentTitle,
                    style: const TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w800,
                      fontFamily: "natoSans",
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 2.0,
                          offset: Offset(0.1, 2.0),
                        )
                      ],
                    ),
                    colors: const [
                      Color.fromRGBO(100, 153, 239, 1),
                      Color.fromRGBO(12, 238, 236, 1),
                      Color.fromRGBO(69, 226, 199, 1),
                      Color.fromRGBO(180, 242, 136, 1),
                      Color.fromRGBO(179, 125, 235, 1),
                    ],
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  if (isLastVideo && isStartPointsAllSelected)
                    buildPurpleOverlapGradientIconButton(
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () async {
                          videoManager.setEditPage(true);
                          videoManager.setCurrentIndex(0);

                          for (var controller in videoManager.controllers) {
                            await controller.seekTo(Duration.zero);
                          }

                          Navigator.of(context)
                              .pushNamed("/selection/editpoints");
                        })
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
                  markers: videoManager.startPoints[videoManager.currentIndex],
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
                  buildGreenGradientIconButton(
                    icon: Icons.cut_rounded,
                    width: 50,
                    height: 50,
                    iconSize: 30,
                    onPressed: () {
                      final currentPosition = controller.value.position;

                      videoManager.replaceMarker(context, currentPosition);
                    },
                  ),
                  buildGreenGradientIconButton(
                    icon: Icons.restore,
                    width: 50,
                    height: 50,
                    iconSize: 30,
                    onPressed: () {
                      videoManager.resetMarkerList();
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
