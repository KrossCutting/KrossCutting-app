import 'package:flutter/material.dart';
import 'package:krosscutting_app/constants/type.dart';

class VideoDirectionProvider with ChangeNotifier {
  String _directionType = BUTTON_TYPE.VERTICAL;

  void setVideoDirection(direction) {
    _directionType = direction;

    notifyListeners();
  }

  String get direction => _directionType;
}
