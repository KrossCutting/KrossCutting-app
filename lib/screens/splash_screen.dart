import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:krosscutting_app/widgets/gradient_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/intro.gif"),
          fit: BoxFit.cover,
          opacity: 0.4,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage("assets/logo_square.png"),
                width: 500,
                height: 500,
              ),
              const SizedBox(
                height: 40,
              ),
              GradientButton(
                buttonText: "Try me",
                onClick: () {
                  Navigator.pushNamed(context, "/permission");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
