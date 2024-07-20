import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/view/widgets/form_screen/grids_view/DayDataGrid.dart';
import 'package:test/view/widgets/form_screen/grids_view/timeGrid.dart';
import 'package:test/view/widgets/register_hint_tile.dart';

class Step5 extends StatefulWidget {
  const Step5({super.key});

  @override
  State<Step5> createState() => _Step5State();
}

class _Step5State extends State<Step5> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  double opacityValue = 0.5;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return SingleChildScrollView(
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
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
                    title: 'formHint5',
                    color: Colors.orange,
                  ),
                ),
              ),
              SizedBox(height: ratio * 10),
              Text.rich(
                TextSpan(
                  text: 'day good for you'.tr(),
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
              DayDataGrid(cubit: cubit),
              Text.rich(
                TextSpan(
                  text: 'time good for you'.tr(),
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
              const Timegrid(),
              Text.rich(
                TextSpan(
                  text: 'hour good for you'.tr(),
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
              const Timegrid2(),
            ],
          );
        },
      ),
    );
  }
}
