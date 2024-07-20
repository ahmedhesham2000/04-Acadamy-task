import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/controller/helper/cashHelper.dart';
import 'package:test/model/request/form_request.dart';
import 'package:test/view/widgets/custome_text_field.dart';
import 'package:test/view/widgets/register_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = 'register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  ));

  late final Tween<Offset> textFormFieldAnmition = Tween<Offset>(
    begin: const Offset(-1, 0.0),
    end: Offset.zero,
  );
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Widget> flowTextFormFields = [];
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  @override
  void initState() {
    super.initState();
    if (AppCubit.get(context).localFormData != null) {
      FormRequest formRequest = AppCubit.get(context).localFormData!;
      controllers[0].text = formRequest.firstName!;
      controllers[1].text = formRequest.familyName!;
      controllers[2].text = formRequest.phone!;
      controllers[3].text = formRequest.email!;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addList();
    });
    // addList();
  }

  double listHeight = ratio * 500;
  addList() {
    List<Widget> list = [
      CustomTextFormField(
        label: 'First Name',
        controller: controllers[0],
        required: true,
        validator: (v) {
          if (v!.isEmpty) {
            return 'First Name is required'.tr();
          }
          return null;
        },
      ),
      CustomTextFormField(
        label: 'Family Name',
        controller: controllers[1],
        required: true,
        validator: (v) {
          if (v!.isEmpty) {
            return 'Family Name is required'.tr();
          }
          return null;
        },
      ),
      CustomTextFormField(
        label: 'Phone',
        controller: controllers[2],
        required: true,
        keyboardType: TextInputType.phone,
        validator: (v) {
          if (v!.isEmpty) {
            return 'Phone Number is required'.tr();
          }
          return null;
        },
      ),
      CustomTextFormField(
        label: 'Email',
        controller: controllers[3],
        required: true,
        keyboardType: TextInputType.emailAddress,
        validator: (v) {
          if (v!.isEmpty) {
            return 'Email is required'.tr();
          }
          if (!v.contains('@')) {
            return 'Email is not valid'.tr();
          }
          if (!v.contains('com') && !v.contains('net') && !v.contains('org')) {
            return 'Email is not valid'.tr();
          }
          return null;
        },
      ),
      CustomTextFormField(
        label: 'Password',
        controller: controllers[4],
        required: true,
        validator: (v) {
          if (v!.isEmpty) {
            return 'Password is required'.tr();
          }
          return null;
        },
      ),
      CustomTextFormField(
        label: 'Confirm Password',
        controller: controllers[5],
        required: true,
        validator: (v) {
          if (v!.isEmpty) {
            return 'Confirm Password is required'.tr();
          }
          if (v != controllers[4].text) {
            return 'Password and Confirm Password must match'.tr();
          }
          return null;
        },
      ),
    ];
    Future ft = Future(() {});
    for (var element in list) {
      ft = ft.then((value) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          flowTextFormFields.add(element);
          _listKey.currentState!.insertItem(flowTextFormFields.length - 1);
        });
      });
    }
    //  flowTextFormFields.add(element);
    // _listKey.currentState!.insertItem(flowTextFormFields.length - 1);
  }

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.only(
              top: ratio * 50.0, left: ratio * 20.0, right: ratio * 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SlideTransition(
                  position: _offsetAnimation,
                  child: Text('Register'.tr(),
                      style: TextStyle(fontSize: textSize * 30)),
                ),
                SizedBox(
                  height: listHeight,
                  child: AnimatedList(
                      key: _listKey,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index, animation) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: ratio * 8.0),
                          child: SlideTransition(
                            position: animation.drive(textFormFieldAnmition),
                            child: flowTextFormFields[index],
                          ),
                        );
                      }),
                ),
                // SizedBox(height: ratio * 25),
                // * Register Button
                CustomeButton(
                    title: 'Register',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        cubit.formRequest = cubit.formRequest.copyWith(
                          firstName: controllers[0].text,
                          familyName: controllers[1].text,
                          phone: controllers[2].text,
                          email: controllers[3].text,
                        );
                        await CacheHelper.saveData(
                          key: 'formRequest',
                          value: cubit.formRequest.toJson(),
                          )
                          .then(
                            (value) {
                              context.push('/form');
                            },
                        );

                        // cubit.postForm(
                        //   firstName: controllers[0].text,
                        //   familyName: controllers[1].text,
                        //   whatsapp: controllers[2].text,
                        //   email: controllers[3].text,
                        // );
                      } else {
                        setState(() {
                          listHeight = ratio * 600;
                        });
                      }
                    }),
                SizedBox(height: ratio * 25),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ratio * 1.0),
                      child: Text(
                        'or login with'.tr(),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ratio * 25),
                CustomOutlineBotton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/google_icon.svg',
                        width: ratio * 20.0,
                        height: ratio * 20.0,
                      ),
                      SizedBox(
                        width: ratio * 5.0,
                      ),
                      Text(
                        'Google'.tr(),
                        style: TextStyle(
                            fontSize: textSize * 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ratio * 10),
                CustomOutlineBotton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/apple_icon.svg',
                        width: ratio * 20.0,
                        height: ratio * 20.0,
                      ),
                      SizedBox(
                        width: ratio * 5.0,
                      ),
                      Text(
                        'Apple'.tr(),
                        style: TextStyle(
                            fontSize: textSize * 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(height: ratio * 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomOutlineBotton extends StatelessWidget {
  const CustomOutlineBotton({
    super.key,
    required this.child,
    this.onPressed,
  });
  final Widget child;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width, ratio * 50),
            padding: EdgeInsets.symmetric(
                vertical: ratio * 10, horizontal: ratio * 20),
            side: const BorderSide(
              color: Colors.green,
            ),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.green,
              ),
              borderRadius: BorderRadius.circular(ratio * 10.0),
            )),
        onPressed: onPressed,
        child: child);
  }
}
