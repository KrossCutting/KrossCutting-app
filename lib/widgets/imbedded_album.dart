import 'package:flutter/material.dart';
import 'dart:io';

class ImbeddedAlbum extends StatelessWidget {
  final List<String>? videoPathList;

  const ImbeddedAlbum({
    super.key,
    required this.videoPathList,
  });

  @override
  Widget build(BuildContext context) {
    List<File> videoFileList = videoPathList
            ?.where((path) => path != null)
            .map((path) => File(path))
            .toList() ??
        [];

    return ListView.builder(
      itemCount: videoFileList.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 300,
          child: Container(
            height: 300,
            margin: const EdgeInsetsDirectional.symmetric(
              vertical: 10,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 104, 224, 210),
                width: 0.3,
              ),
            ),
            child: Image.file(videoFileList[index]),
          ),
        );
      },
    );
  }
}
