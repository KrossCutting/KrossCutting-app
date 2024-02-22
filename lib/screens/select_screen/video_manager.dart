import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoManager with ChangeNotifier {
  List<VideoPlayerController> controllers = [];
  List<List<Duration>> startPoints = [];
  List<List<Duration>> editPoints = [];
  List<String> titles = ["Main", "Sub 1", "Sub 2"];
  bool isEditPage = false;
  int currentIndex = 0;

  VideoManager(List<String> videoFiles) {
    for (var video in videoFiles) {
      var controller = VideoPlayerController.asset(video)
        ..initialize().then((_) {
          notifyListeners();
        });

      controllers.add(controller);
      startPoints.add([]);
      editPoints.add([]);
    }
  }

  void setEditPage(bool value) {
    isEditPage = value;
    notifyListeners();
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void replaceMarker(BuildContext context, Duration marker) {
    if (marker.inSeconds > 60) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "The starting point cannot exceed \n1 minute of the video.",
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Montserrat",
            ),
            textAlign: TextAlign.center,
          ),
          duration: const Duration(seconds: 1),
          backgroundColor: Colors.black.withOpacity(0.8),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
        ),
      );

      return;
    }

    if (startPoints[currentIndex].isNotEmpty) {
      startPoints[currentIndex].clear();
    }
    startPoints[currentIndex].add(marker);
    notifyListeners();
  }

  void addMarker(Duration marker) {
    editPoints[currentIndex].add(marker);
    notifyListeners();
  }

  void resetMarkerList() {
    List<Duration> currentMarkers =
        isEditPage ? editPoints[currentIndex] : startPoints[currentIndex];

    currentMarkers.clear();
    notifyListeners();
  }

  void deleteMarker(VideoPlayerController controller) {
    if (editPoints[currentIndex].isEmpty) return;

    final currentPlayTime = controller.value.position;
    Duration? closestMarker;
    int closestDistance = controller.value.duration.inMilliseconds;

    for (var marker in editPoints[currentIndex]) {
      final int distance = (marker - currentPlayTime).inMilliseconds.abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        closestMarker = marker;
      }
    }

    if (closestMarker != null) {
      editPoints[currentIndex].remove(closestMarker);
      notifyListeners();
    }
  }

  void seekToClosestMarker(VideoPlayerController controller) {
    List<Duration> currentMarkers =
        isEditPage ? editPoints[currentIndex] : startPoints[currentIndex];

    if (currentMarkers.isEmpty) return;

    final currentPlayTime = controller.value.position;
    Duration closestMarker = currentMarkers.first;

    int closestDistance =
        (closestMarker - currentPlayTime).inMilliseconds.abs();

    for (var marker in currentMarkers) {
      final int distance = (marker - currentPlayTime).inMilliseconds.abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        closestMarker = marker;
      }
    }

    controller.seekTo(closestMarker);
  }

  String get currentTitle => titles[currentIndex];

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }

    super.dispose();
  }
}
