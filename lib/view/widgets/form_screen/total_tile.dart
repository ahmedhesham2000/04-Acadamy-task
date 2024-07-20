import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class TotalTile extends StatelessWidget {
  const TotalTile({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Row(
      children: [
        Container(
            width: ratio * 10,
            height: ratio * 70,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(ratio * 10),
            )),
        SizedBox(width: ratio * 10),
        Expanded(
          child: Container(
              width: ratio * 10,
              padding: EdgeInsets.symmetric(horizontal: ratio * 10),
              height: ratio * 70,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(ratio * 5),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                    '${'Total:'.tr()} ${cubit.selectedSubscription.price} ${'currency'.tr()}',
                    style: TextStyle(fontSize: textSize * 16)),
              )),
        ),
      ],
    );
  }
}
