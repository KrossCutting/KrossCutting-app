import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:krosscutting_app/constants/type.dart';
import 'package:krosscutting_app/provider/video_path_provider.dart';
import 'package:krosscutting_app/widgets/gradient_button.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';
import 'package:krosscutting_app/screens/album_screen/selection_row.dart';

class EmbeddedAlbum extends StatefulWidget {
  const EmbeddedAlbum({
    super.key,
  });

  @override
  State<EmbeddedAlbum> createState() => _EmbeddedAlbumState();
}

class _EmbeddedAlbumState extends State<EmbeddedAlbum> {
  @override
  void initState() {
    super.initState();

    Provider.of<VideoPathProvider>(context, listen: false).resetVideoPath();
  }

  void uploadFile(videoPathMap, context) async {
    var url = Uri.parse("${dotenv.env["SERVER_HOST"]}/videos/contents/files");
    var request = http.MultipartRequest("POST", url);

    for (var videoPathKey in videoPathMap.keys) {
      if (videoPathMap[videoPathKey] != null) {
        File file = File(videoPathMap[videoPathKey]);

        if (!await file.exists()) {
          continue;
        }

        var multipartFile = http.MultipartFile.fromBytes(
          videoPathKey,
          await File(videoPathMap[videoPathKey]).readAsBytes(),
          filename: videoPathMap[videoPathKey].split("/").last,
        );

        request.files.add(multipartFile);
      }
    }

    var response = await request.send();

    if (response.statusCode != 201) {
      print("응답에러발생");
    }
  }

  void updateVideoManager(BuildContext context) {
    final videoPathProvider =
        Provider.of<VideoPathProvider>(context, listen: false);

    List selectedFiles = videoPathProvider.videoPath.values.toList();
    final videoManager = Provider.of<VideoManager>(context, listen: false);

    videoManager.resetVideoFiles(selectedFiles);
  }

  @override
  Widget build(BuildContext context) {
    final videoPathProvider = Provider.of<VideoPathProvider>(context);
    Size screenSize = MediaQuery.of(context).size;
    List videoPathValues = videoPathProvider.videoPath.values.toList();
    Map videoPathMap = videoPathProvider.videoPath;

    bool isAvailable =
        videoPathValues.where((value) => value != null).toList().length > 1;
    bool isMainSelected = videoPathValues[0] != null;

    return Column(
      children: [
        const SelectionRow(type: VIDEO_TYPE.MAIN),
        const SelectionRow(type: VIDEO_TYPE.SUB_ONE),
        const SelectionRow(type: VIDEO_TYPE.SUB_TWO),
        SizedBox(
          height: screenSize.height * 0.02,
        ),
        isAvailable && isMainSelected
            ? GradientButton(
                buttonText: "NEXT",
                onClick: () {
                  updateVideoManager(context);
                  Navigator.pushNamed(context, "/selection/startpoint");
                  uploadFile(videoPathMap, context);
                },
              )
            : const SizedBox(
                height: 30,
              )
      ],
    );
  }
}
