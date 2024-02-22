import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class CustomVideoProgressIndicator extends StatelessWidget {
  final VideoPlayerController controller;
  final List<Duration> markers;
  final Function(Duration) onMarkerTap;

  const CustomVideoProgressIndicator({
    super.key,
    required this.controller,
    required this.markers,
    required this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    double markerSize = 10;
    double markerHeight = markerSize * 2.5 + 10;

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapUp: (details) {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localOffset = box.globalToLocal(details.globalPosition);
          final Duration position = _getDurationFromDx(
              localOffset.dx, box.size.width, controller.value.duration);

          onMarkerTap(position);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: VideoProgressIndicator(controller, allowScrubbing: true),
            ),
            SizedBox(
                width: double.infinity,
                height: markerHeight,
                child: CustomPaint(
                  painter: VideoMarkerPainter(
                    markers: markers,
                    videoDuration: controller.value.duration,
                  ),
                ))
          ],
        ));
  }

  Duration _getDurationFromDx(double dx, double width, Duration videoDuration) {
    final double poistionRatio = dx / width;
    final int milliseconds =
        (videoDuration.inMilliseconds * poistionRatio).round();

    return Duration(milliseconds: milliseconds);
  }
}

class VideoMarkerPainter extends CustomPainter {
  final List<Duration> markers;
  final Duration videoDuration;

  VideoMarkerPainter({
    required this.markers,
    required this.videoDuration,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    for (var marker in markers) {
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
