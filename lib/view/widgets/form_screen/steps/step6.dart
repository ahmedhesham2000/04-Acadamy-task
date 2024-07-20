import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/view/widgets/form_screen/SubscriptionsListView.dart';
import 'package:test/view/widgets/form_screen/grids_view/SessionGrod.dart';
import 'package:test/view/widgets/register_hint_tile.dart';

class Step6 extends StatefulWidget {
  const Step6({super.key});

  @override
  State<Step6> createState() => _Step6State();
}

class _Step6State extends State<Step6> with SingleTickerProviderStateMixin {
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
                    title: 'formHint6',
                    color: Colors.green,
                  ),
                ),
              ),
              SizedBox(height: ratio * 10),
              Text.rich(
                TextSpan(
                  text: 'how many sessions'.tr(),
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
              const Sessiongrid(),
              Text.rich(
                TextSpan(
                  text: 'how many hours per session'.tr(),
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
              const SessionTimegrid(),
              SizedBox(height: ratio * 10),
              Text.rich(
                TextSpan(
                  text: 'Subscription period'.tr(),
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
              SubscriptionsListView(cubit: cubit)
            ],
          );
        },
      ),
    );
  }
}
