import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/utils/enums/enums.dart';
import 'package:test/view/widgets/custome_text_field.dart';
import 'package:test/view/widgets/register_hint_tile.dart';

// ignore: must_be_immutable
class Step1 extends StatefulWidget {
  Step1({super.key, required this.controller, required this.opacityValue});
  final AnimationController controller;
  double opacityValue;

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> with SingleTickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  TextEditingController helpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: widget.controller,
      curve: Curves.linear,
    ));

    widget.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          widget.opacityValue = 1;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          widget.opacityValue = .5;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 20 * ratio,
          ),
          AnimatedOpacity(
            opacity: widget.opacityValue,
            duration: const Duration(milliseconds: 500), // Animation duration
            curve: Curves.easeInOut, // Optional: Animation curve
            child: SlideTransition(
              position: _offsetAnimation,
              child: const RegisterHintTile(
                title: 'formHint1',
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(height: ratio * 20),
          InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: const Color(0xFF8CE7F1),
                      colorScheme:
                          const ColorScheme.light(primary: Colors.greenAccent),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
                firstDate: DateTime(1920),
                lastDate:
                    DateTime.now().subtract(const Duration(days: 365 * 18)),
                initialDate:
                    DateTime.now().subtract(const Duration(days: 365 * 18)),
              );
              if (date != null) {
                cubit.claculateAge(date);
              }
            },
            child: CustomTextFormField(
              label: 'Birth Date',
              enabled: false,
              controller: TextEditingController(
                  text: cubit.formRequest.age == null
                      ? ''
                      : cubit.formRequest.age.toString()),
              suffixIcon: const Icon(Icons.calendar_month),
            ),
          ),
          SizedBox(height: ratio * 20),
          InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: ratio * 10, horizontal: ratio * 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ratio * 10.0),
                      ),
                      content: SizedBox(
                        width: double.infinity,
                        // height: ratio * 75.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...Gender.values.map((e) {
                                return InkWell(
                                  overlayColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  onTap: () => cubit.changeGender(e),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(ratio * 8.0),
                                        child: Text(
                                          e.name.tr(),
                                          style: TextStyle(
                                            fontSize: textSize * 20,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ]),
                      ),
                    )),
            child: CustomTextFormField(
              label: 'Gender',
              enabled: false,
              controller:
                  TextEditingController(text: cubit.selectedGender?.tr() ?? ''),
            ),
          ),
          SizedBox(height: ratio * 20),
          InkWell(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            onTap: () => showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      contentPadding: EdgeInsets.symmetric(
                          vertical: ratio * 10, horizontal: ratio * 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ratio * 10.0),
                      ),
                      content: SizedBox(
                        width: double.infinity,
                        // height: ratio * 75.0,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                onTap: () => cubit.changeDefucultyInStudy(true),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(ratio * 8.0),
                                      child: Text('Yes'.tr(),
                                          style: TextStyle(
                                              fontSize: textSize * 20)),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                onTap: () =>
                                    cubit.changeDefucultyInStudy(false),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(ratio * 8.0),
                                      child: Text('No'.tr(),
                                          style: TextStyle(
                                              fontSize: textSize * 20)),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                    )),
            child: CustomTextFormField(
              label: 'DesabilityInStudyHint',
              enabled: false,
              controller: TextEditingController(
                  text: cubit.selectedDefucultyInStudy == null
                      ? ''
                      : cubit.selectedDefucultyInStudy!
                          ? 'Yes'.tr()
                          : 'No'.tr()),
            ),
          ),
          SizedBox(height: ratio * 20),
          CustomTextFormField(
            hintText: 'DesabilityInStudyHint2',
            height: 30,
            controller: helpController,
          ),
          SizedBox(height: ratio * 20),
        ],
      ),
    );
  }
}
