import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:krosscutting_app/screens/select_screen/edit_points_controller.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';

class SelectEditPoints extends StatelessWidget {
  const SelectEditPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<VideoManager>(
        builder: (context, videoManager, child) {
          return PageView.builder(
            itemCount: videoManager.controllers.length,
            onPageChanged: videoManager.setCurrentIndex,
            itemBuilder: (context, index) => VideoControllerPage(
              index: index,
            ),
          );
        },
      ),
    );
  }
}
