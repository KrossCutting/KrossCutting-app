import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:krosscutting_app/screens/splash_screen.dart';
import 'package:krosscutting_app/screens/progress_screen.dart';
import 'package:krosscutting_app/screens/permission_screen.dart';
import 'package:krosscutting_app/screens/home_screen/home_screen.dart';
import 'package:krosscutting_app/screens/select_screen/selection_start_vertical.dart';
import 'package:krosscutting_app/screens/select_screen/selection_edit_vertical.dart';
import 'package:krosscutting_app/screens/select_screen/selection_start_horizontal.dart';
import 'package:krosscutting_app/screens/select_screen/selection_edit_horizontal.dart';
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
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: "KrossCutting",
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/permission": (context) => const PermissionScreen(),
        "/home": (context) => const HomeScreen(),
        "/progress": (context) => const ProgressScreen(),
        "/selection/vertical/startpoint": (context) =>
            const SelectionStartVertical(),
        "/selection/vertical/editpoints": (context) =>
            const SelectionVertical(),
        "/selection/horizontal/startpoint": (context) =>
            const SelectionStartHorizontal(),
        "/selection/horizontal/editpoints": (context) =>
            const SelectionHorizontal(),
        "/instruction/fileUpload": (context) => InstructionFileUpload(),
        "/instruction/startPoint": (context) => InstructionStartPoint(),
        "/instruction/editPoint": (context) => InstructionEditPoint(),
      },
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          background: Colors.black,
        ),
        fontFamily: "lobster",
      ),
    );
  }
}
