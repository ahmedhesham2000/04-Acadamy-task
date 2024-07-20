import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/view/widgets/register_button.dart';
import 'package:test/view/widgets/register_hint_tile.dart';
import 'package:test/view/widgets/role_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.white,

            // appBar: AppBar(
            //   title: const Text('Home Screen'),
            // ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ratio * 100.0, horizontal: ratio * 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: _offsetAnimation,
                    child: Text('Register'.tr(),
                        style: TextStyle(fontSize: textSize * 30)),
                  ),
                  SizedBox(height: ratio * 10),
                  const RegisterHintTile(
                    title: 'RegisterHint',
                    color: Colors.green,
                  ),
                  SizedBox(height: ratio * 25),
                  const RoleTile(),

                  SizedBox(height: ratio * 25),

                  // * Register Button
                  CustomeButton(
                    onPressed: cubit.role == null
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBarAnimationStyle: AnimationStyle(
                                  duration: const Duration(milliseconds: 200)),
                              SnackBar(
                                content: Center(
                                  child: Text('SelectRole'.tr(),
                                      style: TextStyle(
                                          fontSize: textSize * 15,
                                          color: Colors.white)),
                                ),
                                dismissDirection: DismissDirection.up,
                                padding: EdgeInsets.symmetric(
                                    vertical: ratio * 10,
                                    horizontal: ratio * 20),
                                duration: const Duration(seconds: 2),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(ratio * 30),
                                ),
                                margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height - 200,
                                  bottom: 10,
                                  left: ratio * 100,
                                  right: ratio * 100,
                                ),
                              ),
                            );
                          }
                        : () {
                            context.go('/register');
                          },
                    title: 'Next',
                  ),
                ],
              ),
            ));
      },
    );
  }
}
