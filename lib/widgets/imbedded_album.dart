import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:krosscutting_app/constants/type.dart';
import 'package:krosscutting_app/provider/video_path_provider.dart';
import 'package:krosscutting_app/widgets/gradient_button.dart';

class ImbeddedAlbum extends StatefulWidget {
  const ImbeddedAlbum({
    super.key,
  });

  @override
  State<ImbeddedAlbum> createState() => _ImbeddedAlbumState();
}

class _ImbeddedAlbumState extends State<ImbeddedAlbum> {
  bool isAllSelected = false;

  @override
  void initState() {
    super.initState();
  }

  void uploadFile(videoPathMap) async {
    var url = Uri.parse("${dotenv.env["SERVER_HOST"]}/videos/contents/files");
    var request = http.MultipartRequest("POST", url);

    for (var videoPathKey in videoPathMap.keys) {
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

    var response = await request.send();

    if (response.statusCode == 200) {
      //TO DO: 네비게이터 Vertical Or Horizontal
    } else {
      //TO DO: 유저에게 안내
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoPathProvider = Provider.of<VideoPathProvider>(context);
    Size screenSize = MediaQuery.of(context).size;
    List videoPathValues = videoPathProvider.videoPath.values.toList();
    Map videoPathMap = videoPathProvider.videoPath;

    bool isAvailable =
        videoPathValues.where((value) => value != null).toList().length > 1;

    return Column(
      children: [
        const SelectionRow(type: VIDEO_TYPE.MAIN),
        const SelectionRow(type: VIDEO_TYPE.SUB_ONE),
        const SelectionRow(type: VIDEO_TYPE.SUB_TWO),
        SizedBox(
          height: screenSize.height * 0.02,
        ),
        isAvailable
            ? GradientButton(
                buttonText: "NEXT",
                onClick: () {
                  uploadFile(videoPathMap);
                },
              )
            : const SizedBox(
                height: 30,
              )
      ],
    );
  }
}

class SelectionRow extends StatefulWidget {
  final Map type;

  const SelectionRow({
    super.key,
    required this.type,
  });

  @override
  State<SelectionRow> createState() => _SelectionRowState();
}

class _SelectionRowState extends State<SelectionRow> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.type["buttonName"],
            style: TextStyle(
              fontSize: screenSize.height * 0.04,
            ),
          ),
          SelectButton(
            typeKey: widget.type["key"],
          ),
        ],
      ),
    );
  }
}

class SelectButton extends StatefulWidget {
  final String typeKey;

  const SelectButton({
    super.key,
    required this.typeKey,
  });

  @override
  State<SelectButton> createState() => _SelectButtonState();
}

class _SelectButtonState extends State<SelectButton> {
  @override
  Widget build(BuildContext context) {
    final videoPathProvider = Provider.of<VideoPathProvider>(context);
    final videoPathMap = videoPathProvider.videoPath;
    bool isSelected = videoPathMap[widget.typeKey] != null;

    Future<void> pickFiles() async {
      XFile? selectedVideo =
          await ImagePicker().pickVideo(source: ImageSource.gallery);

      if (selectedVideo != null) {
        videoPathProvider.setVideoPath(widget.typeKey, selectedVideo.path);
      }
    }

    return isSelected
        ? Row(
            children: [
              const Icon(
                Icons.check_circle,
                size: 40,
                color: Colors.deepPurple,
              ),
              IconButton(
                onPressed: pickFiles,
                icon: const Icon(
                  Icons.replay_circle_filled_rounded,
                  size: 40,
                  color: Color.fromARGB(255, 30, 233, 209),
                ),
              ),
            ],
          )
        : IconButton(
            icon: const Icon(
              size: 40,
              Icons.video_collection_rounded,
            ),
            onPressed: pickFiles,
          );
  }
}
