import 'package:flutter/material.dart';

class DownloadUrlProvider with ChangeNotifier {
  String _videoUrl = "";

  void setVideoUrl(videoUrl) {
    _videoUrl = videoUrl;

    notifyListeners();
  }

  String get finalVideoUrl => _videoUrl;
}
