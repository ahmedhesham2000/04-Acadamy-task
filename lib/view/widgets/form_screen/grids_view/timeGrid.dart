import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class Timegrid extends StatefulWidget {
  const Timegrid({super.key});

  @override
  State<Timegrid> createState() => _TimegridState();
}

class _TimegridState extends State<Timegrid> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: ratio * 8.0,
        mainAxisSpacing: ratio * 8.0,
      ),
      children: [
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            setState(() {
              cubit.isNightSelected = false;
              cubit.isDaySelected = !cubit.isDaySelected;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.isDaySelected ? Colors.green : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'day'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize * 16),
              ),
            ),
          ),
        ),
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            setState(() {
              cubit.isDaySelected = false;
              cubit.isNightSelected = !cubit.isNightSelected;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    cubit.isNightSelected ? Colors.green : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'night'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize * 16),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Timegrid2 extends StatefulWidget {
  const Timegrid2({super.key});

  @override
  State<Timegrid2> createState() => _Timegrid2State();
}

class _Timegrid2State extends State<Timegrid2> {
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: ratio * 8.0,
        mainAxisSpacing: ratio * 8.0,
      ),
      children: [
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            setState(() {
              cubit.is12Selected = false;
              cubit.is15Selected = !cubit.is15Selected;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.is15Selected ? Colors.green : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '15:00',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize * 16),
              ),
            ),
          ),
        ),
        InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            setState(() {
              cubit.is15Selected = false;
              cubit.is12Selected = !cubit.is12Selected;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.is12Selected ? Colors.green : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '12:00'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize * 16),
              ),
            ),
          ),
        )
      ],
    );
  }
}
