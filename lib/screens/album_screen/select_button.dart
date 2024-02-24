import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:krosscutting_app/provider/video_path_provider.dart';

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
