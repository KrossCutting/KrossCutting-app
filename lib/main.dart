import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:krosscutting_app/provider/video_path_provider.dart';

import 'package:krosscutting_app/screens/album_screen.dart';
import 'package:krosscutting_app/screens/home_screen/home_screen.dart';
import 'package:krosscutting_app/screens/splash_screen.dart';
import 'package:krosscutting_app/screens/select_screen/video_select_start_point.dart';
import 'package:krosscutting_app/screens/select_screen/video_select_edit_points.dart';
import 'package:krosscutting_app/screens/progress_screen.dart';

Future<void> main() async {
  await dotenv.load();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VideoPathProvider()),
      ],
      child: MaterialApp(
        title: "KrossCutting",
        initialRoute: "/",
        routes: {
          "/": (context) => const SplashScreen(),
          "/album": (context) => const AlbumScreen(),
          "/home": (context) => const HomeScreen(),
          "/selection/startpoint": (context) => const SelectStartPoint(),
          "/selection/editpoints": (context) => const SelectEditPoints(),
          "/progress": (context) => const ProgressScreen(),
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

/** 민지님 분리해야하는 provider
 *
 * import 'package:krosscutting_app/screens/select_screen/video_manager.dart';
 * ChangeNotifierProvider(
      create: (context) => VideoManager([
        // TODO. mockup 비디오 경로로, 모든 로직 구현 후 삭제합니다.
        "assets/videos/aespaVertical_main.mp4",
        "assets/videos/aespaVertical_One.mp4",
        "assets/videos/aespaVertical_Two.mp4"
      ]),
 */

