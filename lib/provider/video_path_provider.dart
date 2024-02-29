import 'package:flutter/material.dart';
import 'package:krosscutting_app/constants/type.dart';

class VideoPathProvider with ChangeNotifier {
  Map _videoPath = {
    VIDEO_TYPE.MAIN["key"]: null,
    VIDEO_TYPE.SUB_ONE["key"]: null,
    VIDEO_TYPE.SUB_TWO["key"]: null,
  };

  void setVideoPath(String videoPathKey, String videoPathValue) {
    _videoPath[videoPathKey] = videoPathValue;

    notifyListeners();
  }

  void resetVideoPath() {
    _videoPath = {
      VIDEO_TYPE.MAIN["key"]: null,
      VIDEO_TYPE.SUB_ONE["key"]: null,
      VIDEO_TYPE.SUB_TWO["key"]: null,
    };

    notifyListeners();
  }

  Map get videoPath => _videoPath;
  String get mainVideoPath => _videoPath[VIDEO_TYPE.MAIN["key"]];
  String get subOneVideoPath => _videoPath[VIDEO_TYPE.SUB_ONE["key"]];
  String get subTwoPath => _videoPath[VIDEO_TYPE.SUB_TWO["key"]];
}
