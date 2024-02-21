import 'package:flutter/material.dart';
import 'package:krosscutting_app/screens/home_page/home_page.dart';
import 'package:krosscutting_app/screens/permission_screen.dart';
import 'package:krosscutting_app/screens/progress_screen.dart';
import 'package:krosscutting_app/screens/splash_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  await dotenv.load();
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
        "/progress": (context) => const ProgressScreen(),
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
