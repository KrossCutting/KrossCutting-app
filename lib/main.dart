import 'package:flutter/material.dart';
import 'package:krosscutting_app/screens/album_screen.dart';
import 'package:krosscutting_app/screens/home_page/home_page.dart';
import 'package:krosscutting_app/screens/splash_screen.dart';

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
        "/album": (context) => const AlbumScreen(),
        "/home": (context) => const HomeScreen(),
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
