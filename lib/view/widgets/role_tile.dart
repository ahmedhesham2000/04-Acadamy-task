import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/utils/enums/enums.dart';

class RoleTile extends StatelessWidget {
  const RoleTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          curve: Curves.easeIn,
          duration: const Duration(seconds: 1),
          builder: (context, value, child) => Opacity(
            opacity: value,
            child: Padding(
                padding: EdgeInsets.only(left: ratio * 10 * value),
                child: child!),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    cubit.changeRole(Role.student);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(ratio * 0),
                        child: Image.asset(
                          'assets/images/child.png',
                          width: ratio * 100,
                          height: ratio * 100,
                        ),
                      ),
                      SizedBox(height: ratio * 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (cubit.role == Role.student)
                            const Icon(Icons.check_circle_outline_sharp,
                                color: Colors.green),
                          Text('Student'.tr(),
                              style: TextStyle(fontSize: textSize * 20)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  onTap: () {
                    cubit.changeRole(Role.pearents);
                  },
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(ratio * 0),
                        child: Image.asset(
                          'assets/images/parents.png',
                          width: ratio * 100,
                          height: ratio * 100,
                        ),
                        // SvgPicture.asset(
                        //   'assets/images/pearents.svg',
                        //   width: ratio * 100,
                        //   height: ratio * 100,
                        // ),
                      ),
                      SizedBox(height: ratio * 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (cubit.role == Role.pearents)
                            const Icon(Icons.check_circle_outline_sharp,
                                color: Colors.green),
                          Text('Pearents'.tr(),
                              style: TextStyle(fontSize: textSize * 20)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
