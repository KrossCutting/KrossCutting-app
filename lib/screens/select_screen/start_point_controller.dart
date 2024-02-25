import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:krosscutting_app/screens/select_screen/custom_video_progress_indicator.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';
import 'package:krosscutting_app/widgets/green_gradient_icon_button.dart';

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
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, "/album");
          },
        ),
        title: GradientText(
          videoManager.currentTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            fontFamily: "notoSans",
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
        actions: <Widget>[
          if (isLastVideo && isStartPointsAllSelected)
            IconButton(
              icon: const Icon(Icons.arrow_forward_rounded),
              onPressed: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Center(
                      child: Container(
                        height: 200,
                        margin: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 40,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Would you like to select editing points? \n Pressing 'No' will proceed editing directly",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    "No",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    Navigator.pop(context);

                                    videoManager.setEditPage(true);
                                    videoManager.setCurrentIndex(0);

                                    for (var controller
                                        in videoManager.controllers) {
                                      await controller.seekTo(Duration.zero);
                                    }
                                    Navigator.of(context)
                                        .pushNamed("/selection/editpoints");
                                  },
                                  child: const Text(
                                    "Yes",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  backgroundColor: Colors.transparent,
                );
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Chewie(
              controller: ChewieController(
                videoPlayerController: controller,
                autoPlay: false,
                looping: false,
                aspectRatio: controller.value.aspectRatio,
                showControls: false,
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
    var padding = MediaQuery.of(context).padding;

    return Padding(
      padding: EdgeInsets.only(bottom: padding.bottom),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 250,
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
