import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class SubscriptionsListView extends StatelessWidget {
  const SubscriptionsListView({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ratio * 170,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(
          height: ratio * 10,
        ),
        itemCount: cubit.subscriptions.length,
        itemBuilder: (context, index) => InkWell(
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          onTap: () => cubit.selectSubscription(index),
          child: Card(
            color: Colors.green.withOpacity(0.1),
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: cubit.subscriptions[index].isSelected
                    ? Colors.green
                    : Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.red.withOpacity(0.25),
                    child: Text(
                        '${'discount'.tr()} ${cubit.subscriptions[index].discount!}%',
                        style: TextStyle(
                            fontSize: textSize * 16, color: Colors.red)),
                  ),
                  Text(cubit.subscriptions[index].arTerm!,
                      style: TextStyle(fontSize: textSize * 16)),
                  Text(cubit.subscriptions[index].arPeriod!,
                      style: TextStyle(
                          fontSize: textSize * 12, color: Colors.green)),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          width: ratio * 5,
                          height: ratio * 20,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                          )),
                      SizedBox(width: ratio * 5),
                      Text(
                          '${cubit.subscriptions[index].price} ${'currency'.tr()}',
                          style: TextStyle(
                              fontSize: textSize * 16, color: Colors.green)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
