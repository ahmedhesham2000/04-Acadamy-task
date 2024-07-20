import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class DayDataGrid extends StatelessWidget {
  const DayDataGrid({
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
      itemCount: cubit.dayData.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            cubit.selectDay(index);
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.dayData[index].isSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                cubit.dayData[index].arName!,
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
