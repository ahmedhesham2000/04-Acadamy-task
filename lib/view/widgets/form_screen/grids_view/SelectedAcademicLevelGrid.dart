import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class SelectedAcademicLevelGrid extends StatelessWidget {
  const SelectedAcademicLevelGrid({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: cubit.selectedAcademicLevel?.classes.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),

          onTap: () => cubit.selectClassLevel(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: cubit.selectedAcademicLevel!.classes[index].isSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                cubit.selectedAcademicLevel!.classes[index].name.tr(),
                style: TextStyle(
                  fontSize: textSize * 14,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
