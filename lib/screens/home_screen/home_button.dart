import 'package:flutter/material.dart';
import 'package:krosscutting_app/constants/type.dart';

class HomeButton extends StatelessWidget {
  final String buttonText;
  final String colorStyle;
  final bool isCoachMark;
  final String type;

  const HomeButton({
    super.key,
    required this.buttonText,
    required this.colorStyle,
    required this.isCoachMark,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    void onVerticalClick() {
      //상태
      Navigator.pushNamed(context, "/album");
    }

    void onHorizontalClick() {
      //상태
      Navigator.pushNamed(context, "/album");
    }

    return Stack(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(45),
            gradient: LinearGradient(
              colors: colorStyle == "purple"
                  ? [
                      Colors.purple,
                      Colors.blue,
                    ]
                  : [
                      Colors.yellow,
                      Colors.blue,
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 13,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 58,
                    fontFamily: "lobster",
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!isCoachMark)
          Positioned.fill(
            top: 0,
            left: 0,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(45),
                onTap: type == BUTTON_TYPE.VERTICAL
                    ? onVerticalClick
                    : onHorizontalClick,
              ),
            ),
          )
      ],
    );
  }
}
