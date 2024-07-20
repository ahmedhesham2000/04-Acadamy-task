import 'package:flutter/material.dart';
import 'package:test/view/widgets/register_button.dart';

class PaymentSuccessFooter extends StatefulWidget {
  const PaymentSuccessFooter({super.key});

  @override
  State<PaymentSuccessFooter> createState() => _PaymentSuccessFooterState();
}

class _PaymentSuccessFooterState extends State<PaymentSuccessFooter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  double opacityValue = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
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
    return AnimatedOpacity(
      opacity: opacityValue,
      duration: const Duration(milliseconds: 600),
      child: SlideTransition(
        position: _offsetAnimation,
        child: CustomeButton(
          title: 'توجه الى جدولك الدراسي',
          onPressed: () {},
          radius: 10,
        ),
      ),
    );
  }
}
