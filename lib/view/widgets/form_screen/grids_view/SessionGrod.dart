import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class Sessiongrid extends StatefulWidget {
  const Sessiongrid({super.key});

  @override
  State<Sessiongrid> createState() => _SessiongridState();
}

class _SessiongridState extends State<Sessiongrid> {
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
              cubit.isTwoSessionSelected = false;
              cubit.isOneSessionSelected = !cubit.isOneSessionSelected;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.isOneSessionSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'one session'.tr(),
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
              cubit.isOneSessionSelected = false;
              cubit.isTwoSessionSelected = !cubit.isTwoSessionSelected;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.isTwoSessionSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'two session'.tr(),
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

class SessionTimegrid extends StatefulWidget {
  const SessionTimegrid({super.key});

  @override
  State<SessionTimegrid> createState() => _SessionTimegridState();
}

class _SessionTimegridState extends State<SessionTimegrid> {
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
              cubit.isOneHourSelected = !cubit.isOneHourSelected;
              cubit.isTwoHourSelected = false;
              cubit.isOneHalfHourSelected = false;
              cubit.isTwoHalfHourSelected = false;
              cubit.isHalfHourSelected = false;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    cubit.isOneHourSelected ? Colors.green : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'one hour'.tr(),
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
              cubit.isOneHourSelected = false;
              cubit.isTwoHourSelected = !cubit.isTwoHourSelected;
              cubit.isOneHalfHourSelected = false;
              cubit.isTwoHalfHourSelected = false;
              cubit.isHalfHourSelected = false;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color:
                    cubit.isTwoHourSelected ? Colors.green : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'two hour'.tr(),
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
              cubit.isOneHourSelected = false;
              cubit.isTwoHourSelected = false;
              cubit.isTwoHalfHourSelected = !cubit.isTwoHalfHourSelected;
              cubit.isOneHalfHourSelected = false;
              cubit.isHalfHourSelected = false;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.isTwoHalfHourSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'two and half hour'.tr(),
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
              cubit.isOneHourSelected = false;
              cubit.isTwoHourSelected = false;
              cubit.isTwoHalfHourSelected = false;
              cubit.isOneHalfHourSelected = !cubit.isHalfHourSelected;
              cubit.isHalfHourSelected = false;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.isOneHalfHourSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'one and half hour'.tr(),
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
              cubit.isOneHourSelected = false;
              cubit.isTwoHourSelected = false;
              cubit.isTwoHalfHourSelected = false;
              cubit.isOneHalfHourSelected = false;
              cubit.isHalfHourSelected = !cubit.isHalfHourSelected;
            });
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.isHalfHourSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '30 minutes'.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize * 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
