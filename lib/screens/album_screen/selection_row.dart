import 'package:flutter/material.dart';

import 'package:krosscutting_app/screens/album_screen/select_button.dart';

class SelectionRow extends StatefulWidget {
  final Map type;

  const SelectionRow({
    super.key,
    required this.type,
  });

  @override
  State<SelectionRow> createState() => _SelectionRowState();
}

class _SelectionRowState extends State<SelectionRow> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      height: screenSize.height * 0.13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.type["buttonName"],
            style: TextStyle(
              fontSize: screenSize.height * 0.04,
            ),
          ),
          SelectButton(
            typeKey: widget.type["key"],
          ),
        ],
      ),
    );
  }
}
