import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:test/controller/const.dart';
import 'package:test/view/widgets/register_hint_tile.dart';

class PaymentScusses extends StatefulWidget {
  const PaymentScusses({super.key});

  @override
  State<PaymentScusses> createState() => _PaymentScussesState();
}

class _PaymentScussesState extends State<PaymentScusses>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimationForHint;
  late Animation<Offset> _offsetAnimationForText;
  double opacityValue = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    _offsetAnimationForHint = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _offsetAnimationForText = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          opacityValue = 1;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          opacityValue = .5;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: ratio * 16),
          AnimatedOpacity(
            opacity: opacityValue,
            duration: const Duration(milliseconds: 500), // Animation duration
            curve: Curves.easeInOut, // Optional: Animation curve
            child: SlideTransition(
              position: _offsetAnimationForHint,
              child: const RegisterHintTile(
                title: 'formHint8',
                color: Colors.green,
              ),
            ),
          ),
          SizedBox(height: ratio * 16),
          Lottie.asset(
            'assets/json/success.json',
            width: ratio * 350,
            height: ratio * 350,
          ),
          AnimatedOpacity(
            opacity: opacityValue,
            duration: const Duration(milliseconds: 500), // Animation duration
            curve: Curves.easeInOut, // Optional: Animation curve
            child: SlideTransition(
                position: _offsetAnimationForText,
                child: Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'payment success'.tr(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: textSize * 20,
                          fontFamily: 'Alexandria',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: '\n${'grading'.tr()}',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: textSize * 16,
                          fontFamily: 'Alexandria',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
