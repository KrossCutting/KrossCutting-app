import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:krosscutting_app/widgets/logo_gradient_button.dart';
import 'package:krosscutting_app/widgets/purple_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/purple_overlap_gradient_icon_button.dart';

class SelectionHorizontal extends StatefulWidget {
  const SelectionHorizontal({super.key});

  @override
  State<SelectionHorizontal> createState() => _SelectionHorizontalState();
}

class _SelectionHorizontalState extends State<SelectionHorizontal> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  List<Duration> markerList = [];

  @override
  void initState() {
    super.initState();
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    _videoPlayerController =
        VideoPlayerController.asset("assets/aespaOne_1min.mp4");

    await _videoPlayerController.initialize();

    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      looping: false,
      showControls: false,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  void _addMarker(Duration position) {
    if (!markerList.any((marker) => marker == position)) {
      setState(() {
        markerList.add(position);
      });
    }
  }

  void _deleteMarker(Duration position) {
    final currentPosition = _videoPlayerController.value.position;

    if (markerList.isEmpty) return;

    markerList.sort((a, b) => (a.inMilliseconds -
            currentPosition.inMilliseconds)
        .abs()
        .compareTo((b.inMilliseconds - currentPosition.inMilliseconds).abs()));

    setState(() {
      markerList.removeAt(0);
    });
  }

  void _seekToClosestMarker(Duration targetPosition) {
    Duration? closestMarker;
    int closestDistance = _videoPlayerController.value.duration.inMilliseconds;

    for (var marker in markerList) {
      int distance = (targetPosition - marker).inMilliseconds.abs();
      if (distance < closestDistance) {
        closestDistance = distance;
        closestMarker = marker;
      }
    }

    if (closestMarker != null) {
      _videoPlayerController.seekTo(closestMarker);
    }
  }

  void _resetMarker() {
    setState(() {
      markerList.length = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            _chewieController != null &&
                    _chewieController!.videoPlayerController.value.isInitialized
                ? Positioned(
                    top: 230,
                    left: 0,
                    right: 0,
                    child: AspectRatio(
                      aspectRatio: _chewieController!
                          .videoPlayerController.value.aspectRatio,
                      child: Chewie(controller: _chewieController!),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildOverlapGradientIconButton(
                            icon: Icons.arrow_back_rounded,
                            onPressed: () {
                              // TODO: 화살표 버튼 클릭 시 다음 영상(sub1/sub2)로 넘어갑니다.
                            },
                          ),
                          GradientText(
                            "Main",
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
                          ),
                          buildLogoGradientIconButton(
                            logo: Image.asset(
                              "assets/images/logo_icon_white.png",
                              height: 60,
                              width: 60,
                            ),
                            onPressed: () {
                              // TODO: 로고 이미지 버튼 클릭 시 홈화면으로 돌아갑니다.
                              Navigator.of(context).pushNamed("/home");
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: Container()),
                    const Text(
                      "Edit points",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 45,
                        fontWeight: FontWeight.w600,
                        fontFamily: "lobster",
                        shadows: [
                          Shadow(
                            color: Colors.black,
                            blurRadius: 2.0,
                            offset: Offset(2.0, 2.0),
                          )
                        ],
                      ),
                    ),
                    PlayerControls(
                      controller: _videoPlayerController,
                      addMarkerCallback: _addMarker,
                      resetMarkerCallback: _resetMarker,
                      deleteMarkerCallback: _deleteMarker,
                      seekToMarkerCallback: _seekToClosestMarker,
                      markerList: markerList,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlayerControls extends StatefulWidget {
  final VideoPlayerController controller;
  final Function(Duration position) addMarkerCallback;
  final Function(Duration position) deleteMarkerCallback;
  final Function(Duration position) seekToMarkerCallback;
  final Function() resetMarkerCallback;
  final List<Duration> markerList;

  const PlayerControls({
    super.key,
    required this.controller,
    required this.addMarkerCallback,
    required this.deleteMarkerCallback,
    required this.seekToMarkerCallback,
    required this.resetMarkerCallback,
    required this.markerList,
  });

  @override
  PlayerControlsState createState() => PlayerControlsState();
}

class PlayerControlsState extends State<PlayerControls> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 15),
            child: CustomVideoProgressIndicator(
              controller: widget.controller,
              markerList: widget.markerList,
              onMarkerTap: widget.seekToMarkerCallback,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.replay_5_rounded,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () {
                  widget.controller.seekTo(
                    widget.controller.value.position -
                        const Duration(seconds: 5),
                  );
                },
              ),
              IconButton(
                icon: Icon(
                  widget.controller.value.isPlaying
                      ? Icons.pause
                      : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 50,
                ),
                onPressed: () {
                  setState(() {
                    if (widget.controller.value.isPlaying) {
                      widget.controller.pause();
                    } else {
                      widget.controller.play();
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
                  widget.controller.seekTo(
                    widget.controller.value.position +
                        const Duration(seconds: 5),
                  );
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
              buildGradientIconButton(
                // TODO: 아래의 State를 전역을 변경하고, 변경된 전역상태를 조정해야합니다.
                icon: Icons.auto_fix_high,
                onPressed: () {
                  widget.addMarkerCallback(widget.controller.value.position);
                  // TODO. currentVideoPosition의 정보를 전역으로 보내야합니다.
                  // TODO. (현재는 지역 state로 구현되어 있습니다.)
                  // TODO. currentVideoPosition은 아이콘을 선택할 당시 영상의 분/초 정보입니다.
                },
              ),
              buildGradientIconButton(
                icon: Icons.restore,
                onPressed: () {
                  widget.resetMarkerCallback();
                  // TODO. 전역상태로 변경하고, 전역상태의 currentVideoPosition들을 모두 삭제해야합니다..
                },
              ),
              buildGradientIconButton(
                icon: Icons.highlight_remove,
                onPressed: () {
                  widget.deleteMarkerCallback(widget.controller.value.position);
                  // TODO. 해당(remove) 아이콘 클릭시 해당하는 편집점을 삭제합니다.
                  // TODO. 따라서 선택했던 currentVideoPosition중 해당하는 시점을 삭제합니다.
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomVideoProgressIndicator extends StatelessWidget {
  final VideoPlayerController controller;
  final List<Duration> markerList;
  final Function(Duration position) onMarkerTap;

  const CustomVideoProgressIndicator({
    super.key,
    required this.controller,
    required this.markerList,
    required this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    double markerSize = 10;
    double markerHeight = markerSize * 2.5 + 10;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapUp: (TapUpDetails details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset localOffset = box.globalToLocal(details.globalPosition);
        final double dx = localOffset.dx;
        final Duration positionClicked =
            _getDurationFromDx(dx, box.size.width, controller.value.duration);

        onMarkerTap(positionClicked);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: VideoProgressIndicator(
              controller,
              allowScrubbing: true,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: markerHeight,
            child: CustomPaint(
              painter: VideoMarker(
                videoDuration: controller.value.duration,
                markerList: markerList,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Duration _getDurationFromDx(double dx, double width, Duration videoDuration) {
    final double positionRatio = dx / width;
    final int milliseconds =
        (videoDuration.inMilliseconds * positionRatio).round();
    return Duration(milliseconds: milliseconds);
  }
}

class VideoMarker extends CustomPainter {
  final Duration videoDuration;
  final List<Duration> markerList;

  VideoMarker({
    required this.videoDuration,
    required this.markerList,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (var marker in markerList) {
      final markerPosition =
          (marker.inMilliseconds / videoDuration.inMilliseconds) * size.width;

      Path path = Path();
      double triangleSize = 10;
      path.moveTo(markerPosition, 6);
      path.lineTo(markerPosition - triangleSize, triangleSize * 2);
      path.lineTo(markerPosition + triangleSize, triangleSize * 2);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
