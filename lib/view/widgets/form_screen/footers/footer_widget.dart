import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/controller/helper/error_alert.dart';
import 'package:test/view/screens/register_screen.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.cubit,
  });

  final AppCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (cubit.progress == 2) {
                    cubit.postForm(
                      firstName: cubit.formRequest.firstName!,
                      familyName: cubit.formRequest.familyName!,
                      whatsapp: cubit.formRequest.phone!,
                      email: cubit.formRequest.email!,
                      age: cubit.formRequest.age?.toString(),
                      gender: cubit.formRequest.gender,
                      difficulties: cubit.formRequest.difficulties,
                      help: cubit.formRequest.description,
                    );
                    return;
                  }
                  if (cubit.progress == 3) {
                    if (cubit.selectedAcademicLevel!.classes
                        .where(
                          (element) => element.isSelected == true,
                        )
                        .isEmpty) {
                      errorAlert(context, 'Select the academic levels'.tr());
                      return;
                    }

                    if (cubit.selectedProgrmesLevels == null) {
                      errorAlert(context, 'Select the curriculum'.tr());
                      return;
                    }
                  }
                  if (cubit.progress == 4) {
                    if (cubit.materialData
                        .where(
                          (element) => element.isSelected == true,
                        )
                        .toList()
                        .isEmpty) {
                      errorAlert(context, 'selectMaterial'.tr());
                      return;
                    }
                    // cubit.postCourseForm();
                  }
                  if (cubit.progress == 5) {
                    if (cubit.students
                        .where(
                          (element) => element.isSelected == true,
                        )
                        .toList()
                        .isEmpty) {
                      errorAlert(context, 'howManyStudents'.tr());

                      return;
                    }
                    if (cubit.purposeData
                        .where(
                          (element) => element.isSelected == true,
                        )
                        .toList()
                        .isEmpty) {
                      errorAlert(context, 'choose your objective'.tr());
                      return;
                    }
                    // cubit.postStudentForm();
                  }
                  if (cubit.progress == 6) {
                    if (cubit.dayData
                        .where(
                          (element) => element.isSelected == true,
                        )
                        .toList()
                        .isEmpty) {
                      errorAlert(context, 'day good for you'.tr());
                      return;
                    }
                    if (!cubit.isDaySelected && !cubit.isNightSelected) {
                      errorAlert(context, 'time good for you'.tr());
                      return;
                    }
                    if (!cubit.is12Selected && !cubit.is15Selected) {
                      errorAlert(context, 'hour good for you'.tr());
                      return;
                    }
                    // cubit.postTimeForm();
                  }
                  if (cubit.progress == 7) {
                    if (!cubit.isOneSessionSelected &&
                        !cubit.isTwoSessionSelected) {
                      errorAlert(context, 'how many sessions'.tr());
                      return;
                    }
                    if (!cubit.isOneHalfHourSelected &&
                        !cubit.isOneHourSelected &&
                        !cubit.isTwoHourSelected &&
                        !cubit.isTwoHalfHourSelected &&
                        !cubit.isHalfHourSelected) {
                      errorAlert(context, 'how many hours per session'.tr());
                      return;
                    }
                    if (cubit.subscriptions
                        .where((element) => element.isSelected == true)
                        .toList()
                        .isEmpty) {
                      errorAlert(context, 'choose your subscription'.tr());
                      return;
                    }
                  }
                  if (cubit.progress == 8) {
                    if (cubit.formKey7.currentState!.validate()) {
                      if (cubit.agreeToTerms) {
                        cubit.callAllRequests();
                      } else {
                        errorAlert(context, 'agreeToTerms'.tr());
                      }
                    }
                  } else {
                    cubit.updateProgress();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      cubit.role == null ? Colors.green.shade200 : Colors.green,
                  disabledBackgroundColor: Colors.green.shade200,
                  fixedSize:
                      Size(MediaQuery.of(context).size.width, ratio * 50),
                  padding: EdgeInsets.symmetric(
                      vertical: ratio * 10, horizontal: ratio * 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ratio * 10),
                  ),
                ),
                child: Text('Next2'.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: textSize * 20, color: Colors.white)),
              ),
            ),
            SizedBox(width: ratio * 10),
            Expanded(
                child: CustomOutlineBotton(
                    onPressed: () {
                      cubit.updateProgressBack();
                    },
                    child: Text(
                      'Back'.tr(),
                      style: TextStyle(
                          fontSize: textSize * 20, color: Colors.green),
                    ))),
          ].reversed.toList(),
        );
      },
    );
  }
}
