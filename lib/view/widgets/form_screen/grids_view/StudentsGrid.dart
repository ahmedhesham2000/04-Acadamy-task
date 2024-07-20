import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class StudentsGrid extends StatelessWidget {
  const StudentsGrid({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: ratio * 8.0,
        mainAxisSpacing: ratio * 8.0,
      ),
      itemCount: cubit.students.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            cubit.selectStudent(index);
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.students[index].isSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                cubit.students[index].text.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: textSize * 16),
              ),
            ),
          ),
        );
      },
    );
  }
}
