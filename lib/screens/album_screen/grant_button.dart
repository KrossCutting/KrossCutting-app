import 'package:flutter/material.dart';

class GrantButton extends StatelessWidget {
  final Function()? onClickGrantButton;

  const GrantButton({
    super.key,
    this.onClickGrantButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(45),
            border: const Border(
              top: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
              bottom: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
              left: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
              right: BorderSide(
                color: Colors.purple,
                width: 2.0,
              ),
            ),
          ),
          child: TextButton(
            onPressed: onClickGrantButton,
            child: const Text(
              "Get Permission",
              style: TextStyle(
                fontSize: 30,
                fontFamily: "notoSansItalic",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
