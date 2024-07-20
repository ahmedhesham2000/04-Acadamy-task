import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class MaterialDataGrid extends StatelessWidget {
  const MaterialDataGrid({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: ratio * 8.0,
        mainAxisSpacing: ratio * 8.0,
      ),
      itemCount: cubit.materialData.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () {
            cubit.selectMaterial(index);
          },
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.materialData[index].isSelected!
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.language, size: ratio * 50, color: Colors.green),
                  SizedBox(height: ratio * 8),
                  Text(
                    cubit.materialData[index].arName!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: textSize * 16),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
