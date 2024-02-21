import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:krosscutting_app/screens/select_screen/start_point_controller.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';

class SelectStartPoint extends StatelessWidget {
  const SelectStartPoint({super.key});

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
