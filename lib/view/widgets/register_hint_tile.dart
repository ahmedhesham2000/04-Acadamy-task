import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';

class RegisterHintTile extends StatelessWidget {
  const RegisterHintTile({
    super.key,
    required this.title,
    required this.color,
  });
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: ratio * 10,
            height: ratio * 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(ratio * 10),
            )),
        SizedBox(width: ratio * 10),
        Expanded(
          child: Text(title.tr(), style: TextStyle(fontSize: textSize * 16)),
        ),
      ],
    );
  }
}
