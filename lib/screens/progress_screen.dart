import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krosscutting_app/services/editing_status.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  static const int _imageDisplayInterval = 500;

  bool shouldRequestStatus = true;
  int _currentStep = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: _imageDisplayInterval),
        (timer) {
      setState(() {
        _currentStep = (_currentStep + 1) % 5;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    shouldRequestStatus = false;
    super.dispose();
  }

  Widget _circleDecoration(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withOpacity(0.7),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _cutImage(bool isVisible) {
    return Visibility(
      visible: isVisible,
      maintainSize: true,
      maintainState: true,
      maintainAnimation: true,
      child: const Image(
        image: AssetImage("assets/images/cut.png"),
        width: 40,
        height: 40,
      ),
    );
  }

  List<Widget> _buildImageRow() {
    List<Widget> widgets = [
      _cutImage(true),
      const SizedBox(
        width: 15,
      ),
    ];
    for (int i = 0; i < 4; i++) {
      widgets.add(
        _cutImage(i < _currentStep),
      );
      if (i < 4) {
        widgets.add(
          const SizedBox(width: 15),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  _circleDecoration(140, Colors.purple[700]!),
                  _circleDecoration(110, Colors.purple[100]!),
                  const Image(
                    image: AssetImage(
                      "assets/images/icon_logo_mini.png",
                    ),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              EditingStatus(isEnable: shouldRequestStatus),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildImageRow(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
