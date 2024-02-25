int trimTimeStringToInt(String timeString) {
  String seconds = timeString.split(":").last;
  int milliSeconds = int.parse(seconds.split(".").last);
  int finalSeconds = int.parse(seconds.split(".").first);

  if (milliSeconds > 500000) {
    finalSeconds += 1;
  }

  return finalSeconds;
}

Map<String, Map<String, dynamic>> formattingPointsData(
    Map<String, dynamic> pointsData) {
  Map<String, int> startPointListMap = {
    "mainStartPoint": pointsData["startPointList"][0],
    "subOneStartPoint": pointsData["startPointList"][1],
    "subTwoStartPoint": pointsData["startPointList"][2],
  };

  Map<String, List> editPointListMap = {
    "mainEditPoint": pointsData["editPointList"][0],
    "subOneEditPoint": pointsData["editPointList"][1],
    "subTwoEditPoint": pointsData["editPointList"][2],
  };

  return {
    "startPoints": startPointListMap,
    "selectedEditPoints": editPointListMap,
  };
}
