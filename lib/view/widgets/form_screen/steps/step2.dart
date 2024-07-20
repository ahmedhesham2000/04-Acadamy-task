import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/view/widgets/form_screen/grids_view/ProgrmesLevelsGrid.dart';
import 'package:test/view/widgets/form_screen/grids_view/SelectedAcademicLevelGrid.dart';
import 'package:test/view/widgets/register_hint_tile.dart';

// ignore: must_be_immutable
class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step2State();
}

class _Step2State extends State<Step2> with SingleTickerProviderStateMixin {
  late Animation<Offset> _offsetAnimation;
  double opacityValue = 0.5;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          opacityValue = 1;
        });
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          opacityValue = .5;
        });
      }
    });
    if (AppCubit.get(context).selectedAcademicLevel == null) {
      AppCubit.get(context).selectedAcademicLevel =
          AppCubit.get(context).academicLevels[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return SingleChildScrollView(
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20 * ratio,
              ),
              AnimatedOpacity(
                opacity: opacityValue,
                duration:
                    const Duration(milliseconds: 500), // Animation duration
                curve: Curves.easeInOut, // Optional: Animation curve
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: const RegisterHintTile(
                    title: 'formHint2',
                    color: Colors.orange,
                  ),
                ),
              ),
              SizedBox(height: ratio * 20),
              Text.rich(
                TextSpan(
                  text: 'Select the academic levels'.tr(),
                  style: TextStyle(
                    fontSize: textSize * 20,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontSize: textSize * 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: ratio * 20),
              GridView.builder(
                shrinkWrap: true,
                itemCount: cubit.academicLevels.length,
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
                    onTap: () => cubit.selectAcademicLevel(index),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: cubit.academicLevels[index].isSelected
                              ? Colors.green
                              : Colors.transparent,
                          width: 1,
                        ),
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          cubit.academicLevels[index].name.tr(),
                          style: TextStyle(
                            fontSize: textSize * 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: ratio * 20),
              Text.rich(
                TextSpan(
                  text: 'Select the academic levels'.tr(),
                  style: TextStyle(
                    fontSize: textSize * 20,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontSize: textSize * 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: ratio * 20),
              SelectedAcademicLevelGrid(cubit: cubit),
              SizedBox(height: ratio * 20),
              Text.rich(
                TextSpan(
                  text: 'Select the curriculum'.tr(),
                  style: TextStyle(
                    fontSize: textSize * 20,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(
                        fontSize: textSize * 20,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: ratio * 20),
              ProgrmesLevelsGrid(cubit: cubit),
            ],
          );
        },
      ),
    );
  }
}
