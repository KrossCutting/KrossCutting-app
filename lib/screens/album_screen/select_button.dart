import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:krosscutting_app/provider/video_path_provider.dart';
import 'package:krosscutting_app/widgets/purple_gradient_icon_button.dart';
import 'package:krosscutting_app/widgets/green_gradient_icon_button.dart';

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
              buildPurpleGradientIconButton(
                icon: Icons.check_rounded,
                width: 35,
                height: 35,
                iconSize: 30,
                onPressed: () {},
              ),
              const SizedBox(
                width: 15,
              ),
              buildGreenGradientIconButton(
                icon: Icons.replay_rounded,
                width: 35,
                height: 35,
                iconSize: 30,
                onPressed: pickFiles,
              ),
            ],
          )
        : IconButton(
            icon: const Icon(
              size: 35,
              Icons.video_collection_rounded,
            ),
            onPressed: pickFiles,
          );
  }
}
