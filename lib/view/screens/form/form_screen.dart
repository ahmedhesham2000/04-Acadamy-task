import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/controller/helper/error_alert.dart';
import 'package:test/view/widgets/form_screen/footers/footer_widget.dart';
import 'package:test/view/widgets/form_screen/footers/payment_success_footer.dart';
import 'package:test/view/widgets/form_screen/steps/payment_scusses.dart';
import 'package:test/view/widgets/form_screen/steps/step1.dart';
import 'package:test/view/widgets/form_screen/steps/step2.dart';
import 'package:test/view/widgets/form_screen/steps/step3.dart';
import 'package:test/view/widgets/form_screen/steps/Step4.dart';
import 'package:test/view/widgets/form_screen/steps/step5.dart';
import 'package:test/view/widgets/form_screen/steps/step6.dart';
import 'package:test/view/widgets/form_screen/steps/step7.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});
  static const String routeName = 'form';

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final PageController _pageController = PageController();
  final double _opacityValue = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int age = 0;

  @override
  Widget build(BuildContext context) {
    double progressWidth = MediaQuery.of(context).size.width - 32;
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is ChangeGender || state is ChangeDefucultyInStudy) {
          context.pop();
        }
        if (state is PostFormScucess) {
          cubit.updateProgress();
        }
        if (state is PostPaymentScucess) {
          cubit.updateProgress();
        }

        if (state is UpdateProgress) {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 500), curve: Curves.ease);
        }
        if (state is UpdateProgressBack) {
            _pageController.previousPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease);
        }
        if (state is PostAllReuestsLoading) {
          errorAlert(context, 'Please wait'.tr(),
              color: Colors.yellow, textColor: Colors.black);
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: cubit.progress == 10
              ? Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ratio * 20.0, horizontal: ratio * 20.0),
                  child: const PaymentSuccessFooter(),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ratio * 20.0, horizontal: ratio * 20.0),
                  child: FooterWidget(cubit: cubit),
                ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: ratio * 50.0, horizontal: ratio * 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/app_logo.png',
                        width: ratio * 176.0, height: ratio * 53.0),
                    const SizedBox(width: 10),
                    if (cubit.progress != 10)
                      InkWell(
                        
                          child: Text('Skip'.tr(),
                              style: TextStyle(fontSize: textSize * 20))),
                  ],
                ),
                SizedBox(height: ratio * 20),
                Stack(
                  children: [
                    Container(
                      width: progressWidth,
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: progressWidth * (cubit.progress / 10),
                      height: 10.0,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      right: (progressWidth * (cubit.progress / 10)) - 8,
                      top: -3.0,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 16.0,
                        height: 16.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.green, width: 2.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    children: [
                      Step1(
                          controller: _controller, opacityValue: _opacityValue),
                      const Step2(),
                      const Step3(),
                      const Step4(),
                      const Step5(),
                      const Step6(),
                      const Step7(),
                      const PaymentScusses(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
