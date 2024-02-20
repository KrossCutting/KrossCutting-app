import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const splashSeconds = 3;

  @override
  void initState() {
    super.initState();

    Timer(
        const Duration(
          seconds: splashSeconds,
        ), () {
      Navigator.pushNamed(
        context,
        "/album",
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/intro.gif"),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage("assets/images/logo_square.png"),
              width: 500,
              height: 500,
            ),
          ),
        ),
      ),
    );
  }
}
