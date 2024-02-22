import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:krosscutting_app/screens/home_screen/home_screen.dart';
import 'package:krosscutting_app/screens/permission_screen.dart';
import 'package:krosscutting_app/screens/splash_screen.dart';
import 'package:krosscutting_app/screens/progress_screen.dart';
import 'package:krosscutting_app/screens/select_screen/video_manager.dart';
import 'package:krosscutting_app/screens/select_screen/video_select_start_point.dart';
import 'package:krosscutting_app/screens/select_screen/video_select_edit_points.dart';
import 'package:krosscutting_app/screens/instruction_page/instruction_edit_point.dart';
import 'package:krosscutting_app/screens/instruction_page/instruction_file_upload.dart';
import 'package:krosscutting_app/screens/instruction_page/instruction_start_point.dart';

Future main() async {
  await dotenv.load();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => VideoManager([
        // TODO. mockup 비디오 경로로, 모든 로직 구현 후 삭제합니다.
        "assets/videos/aespaVertical_main.mp4",
        "assets/videos/aespaVertical_One.mp4",
        "assets/videos/aespaVertical_Two.mp4"
      ]),
      child: MaterialApp(
        title: "KrossCutting",
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/permission": (context) => const PermissionScreen(),
          "/home": (context) => const HomeScreen(),
          "/selection/startpoint": (context) => const SelectStartPoint(),
          "/selection/editpoints": (context) => const SelectEditPoints(),
          "/progress": (context) => const ProgressScreen(),
          "/instruction/fileUpload": (context) => InstructionFileUpload(),
          "/instruction/startPoint": (context) => InstructionStartPoint(),
          "/instruction/editPoint": (context) => InstructionEditPoint(),

          //TODO. 아래 라우터는 가로/세로 영상별 엔드포인트 분리 여부에 따라 사용여부를 결정합니다.
          //TODO. 가로/세로 영상의 시작점/편집점 선택 엔드포인트가 동일할 경우 삭제합니다.
          /*   "/selection/vertical/startpoint": (context) =>
              const SelectionStartVertical(),
          "/selection/horizontal/startpoint": (context) =>
              const SelectionStartHorizontal(),
          "/selection/vertical/editpoints": (context) =>
              const SelectionVertical(),
          "/selection/horizontal/editpoints": (context) =>
              const SelectionHorizontal(), */
        },
        theme: ThemeData(
          colorScheme: const ColorScheme.dark(
            background: Colors.black,
          ),
          fontFamily: "lobster",
        ),
      ),
    );
  }
}
