import 'package:flutter/material.dart';
import 'package:krosscutting_app/screens/home_screen/home_screen.dart';
import 'package:krosscutting_app/screens/permission_screen.dart';
import 'package:krosscutting_app/screens/splash_screen.dart';
import 'package:krosscutting_app/screens/select_screen/selection_edit_horizontal.dart';
import 'package:krosscutting_app/screens/select_screen/selection_edit_vertical.dart';
import 'package:krosscutting_app/screens/select_screen/selection_start_horizontal.dart';
import 'package:krosscutting_app/screens/select_screen/selection_start_vertical.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KrossCutting",
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/permission": (context) => const PermissionScreen(),
        "/home": (context) => const HomeScreen(),
        "/selection/vertical/startpoint": (context) =>
            const SelectionStartVertical(),
        "/selection/horizontal/startpoint": (context) =>
            const SelectionStartHorizontal(),
        "/selection/vertical/editpoints": (context) =>
            const SelectionVertical(),
        "/selection/horizontal/editpoints": (context) =>
            const SelectionHorizontal(),
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
