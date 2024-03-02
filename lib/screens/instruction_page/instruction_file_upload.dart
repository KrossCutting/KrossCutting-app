import 'package:flutter/material.dart';
import 'package:krosscutting_app/widgets/moving_icon.dart';
import 'package:krosscutting_app/screens/instruction_page/instrunction_coach_mark.dart';

class InstructionFileUpload extends StatelessWidget {
  const InstructionFileUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;

    final List containers = [
      Center(
          child: Column(
        children: [
          SizedBox(
            height: screenHeight * 0.39,
          ),
          Transform.translate(
            offset: const Offset(-30, 0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MovingIcon(
                  isVertical: false,
                  icon: Icon(
                    Icons.chevron_right_rounded,
                    size: 100,
                  ),
                ),
                Icon(
                  Icons.video_collection_rounded,
                  size: 40,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Tap the icon\nand select the video",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            "the main video will\ndominate the composition",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "noteSans",
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      )),
    ];

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            const Center(
              child: Image(
                image: AssetImage("assets/images/album_demo.png"),
              ),
            ),
            InstructionCoachMark(
              onSkip: () {
                Navigator.pushNamed(
                  context,
                  "/instruction/startPoint",
                );
              },
              explainScreen: containers,
            ),
          ],
        ),
      ),
    );
  }
}
