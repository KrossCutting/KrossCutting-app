import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:krosscutting_app/provider/video_path_provider.dart';
import 'package:krosscutting_app/screens/album_screen.dart';
import 'package:krosscutting_app/screens/home_page/home_page.dart';
import 'package:krosscutting_app/screens/splash_screen.dart';

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
