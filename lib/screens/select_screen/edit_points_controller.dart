import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import 'package:krosscutting_app/provider/video_direction_provider.dart';
import 'package:krosscutting_app/screens/select_screen/custom_video_progress_indicator.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';
import 'package:krosscutting_app/widgets/purple_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/purple_overlap_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/green_overlap_gradient_icon_button.dart';

class VideoControllerPage extends StatefulWidget {
  final int index;
  const VideoControllerPage({super.key, required this.index});

  @override
  _VideoControllerPageState createState() => _VideoControllerPageState();
}

class _VideoControllerPageState extends State<VideoControllerPage> {
  int trimTimeStringToInt(String timeString) {
    String seconds = timeString.split(":").last;
    int milliSeconds = int.parse(seconds.split(".").last);
    int finalSeconds = int.parse(seconds.split(".").first);

    if (milliSeconds > 500000) {
      finalSeconds = finalSeconds + 1;
    }

    return finalSeconds;
  }

  void clickNextIconButton(pointsData, direction) {
    postPoints(pointsData, direction);
    //여기에서 일정시간마다 GET요청을 보내는 함수를 실행합니다.
  }

  Future<http.Response> postPoints(
    pointResultData,
    direction,
  ) async {
    String jsonEncodedData = json.encode(pointResultData);
    var url = Uri.parse(
        "${dotenv.env["SERVER_HOST"]}/videos/compilations/$direction");
    var response = await http.post(
      url,
      headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: jsonEncodedData,
    );

    if (response.statusCode == 201) {
      print("편집작업종료");
      //TODO: 편집작업완료
    } else {
      //TODO: 유저에게안내
    }

    return response;
  }

  formattingPointsData(pointsData) {
    print(pointsData);

    Map<String, int> startPointListMap = {
      "mainStartPoint": pointsData["startPointList"][0],
      "subOneStartPoint": pointsData["startPointList"][1],
      "subTwoStartPoint": pointsData["startPointList"].length >= 3
          ? pointsData["startPointList"][2]
          : 0,
    };

    Map<String, List> editPointListMap = {
      "mainEditPoint": pointsData["editPointList"][0],
      "subOneEditPoint": pointsData["editPointList"][1],
      "subTwoEditPoint": pointsData["editPointList"].length >= 3
          ? pointsData["editPointList"][2]
          : [],
    };

    Map<String, Map> result = {
      "startPoints": startPointListMap,
      "selectedEditPoints": editPointListMap,
    };

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final videoManager = Provider.of<VideoManager>(context);
    final videoDirection = Provider.of<VideoDirectionProvider>(context);
    final controller = videoManager.controllers[widget.index];
    final isLastVideo =
        videoManager.currentIndex == videoManager.controllers.length - 1;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            videoManager.setEditPage(false);
            videoManager.setCurrentIndex(videoManager.controllers.length - 1);

            Navigator.of(context).pop();
          },
        ),
        title: GradientText(
          videoManager.currentTitle,
          style: const TextStyle(
            fontSize: 20,
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
            Color.fromRGBO(83, 183, 235, 1),
            Color.fromRGBO(148, 95, 241, 1),
            Color.fromRGBO(162, 38, 243, 1),
            Color.fromRGBO(234, 101, 128, 1),
            Color.fromRGBO(242, 194, 125, 1),
          ],
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          if (isLastVideo)
            IconButton(
                icon: const Icon(Icons.arrow_forward_rounded),
                onPressed: () async {
                  List<List<Duration>> editPointListStatus =
                      videoManager.editPointList;
                  List<List<Duration>> startPointListStatus =
                      videoManager.startPointList;

                  List<List<int>> editPointList =
                      editPointListStatus.map((eachVideoEditPointList) {
                    return eachVideoEditPointList.map((editPointTime) {
                      return trimTimeStringToInt(editPointTime.toString());
                    }).toList();
                  }).toList();

                  List<int> startPointList =
                      startPointListStatus.map((eachVideoStartPointList) {
                    return trimTimeStringToInt(
                        eachVideoStartPointList[0].toString());
                  }).toList();

                  Map<String, List> pointsData = {
                    "editPointList": editPointList,
                    "startPointList": startPointList,
                  };

                  var pointResultData = formattingPointsData(pointsData);

                  clickNextIconButton(
                    pointResultData,
                    videoDirection.direction,
                  );
                })
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
                    icon: Icons.cut_rounded,
                    width: 50,
                    height: 50,
                    iconSize: 30,
                    onPressed: () {
                      final currentPosition = controller.value.position;

                      videoManager.addMarker(currentPosition);
                    },
                  ),
                  buildPurpleGradientIconButton(
                    icon: Icons.restore,
                    width: 50,
                    height: 50,
                    iconSize: 30,
                    onPressed: () {
                      videoManager.resetMarkerList();
                    },
                  ),
                  buildPurpleGradientIconButton(
                    icon: Icons.highlight_remove,
                    width: 50,
                    height: 50,
                    iconSize: 30,
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
