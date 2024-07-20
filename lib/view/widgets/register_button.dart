import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class CustomeButton extends StatelessWidget {
  const CustomeButton({
    super.key,
    required this.title,
    this.radius = 30,
    required this.onPressed,
  });

  final String title;
  final int radius;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 1, end: 0),
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          builder: (context, value, child) => Opacity(
            opacity: value == 1 ? 0 : 1,
            child: Padding(
                padding: EdgeInsets.only(top: value * 10), child: child!),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  cubit.role == null ? Colors.green.shade200 : Colors.green,
              disabledBackgroundColor: Colors.green.shade200,
              fixedSize: Size(MediaQuery.of(context).size.width, ratio * 50),
              padding: EdgeInsets.symmetric(
                  vertical: ratio * 10, horizontal: ratio * 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ratio * radius),
              ),
            ),
            child: Text(title.tr(),
                style: TextStyle(fontSize: textSize * 20, color: Colors.white)),
          ),
        );
      },
    );
  }
}
