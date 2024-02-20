import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String buttonText;
  final String colorStyle;
  final bool isCoachMark;

  const HomeButton({
    super.key,
    required this.buttonText,
    required this.colorStyle,
    required this.isCoachMark,
  });

  void onClick() {
// To Do. 버튼 클릭시 전역 상태에 비디오 타입 전달 후 갤러리 선택 페이지로 이동 기능
    return;
  }

  @override
  Widget build(BuildContext context) {
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
                onTap: onClick,
              ),
            ),
          )
      ],
    );
  }
}
