import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> errorAlert(
    BuildContext context, String message,
    {Color color = Colors.red,Color textColor = Colors.white}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    snackBarAnimationStyle:
        AnimationStyle(duration: const Duration(milliseconds: 200)),
    SnackBar(
      content: Center(
        child: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: textSize * 15, color: textColor)),
      ),
      dismissDirection: DismissDirection.up,
      padding:
          EdgeInsets.symmetric(vertical: ratio * 10, horizontal: ratio * 20),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ratio * 30),
      ),
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height - 200,
        bottom: 10,
        left: ratio * 100,
        right: ratio * 100,
      ),
    ),
  );
}
