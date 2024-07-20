import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';
import 'package:test/model/request/payment_request.dart';
import 'package:test/view/widgets/custome_text_field.dart';
import 'package:test/view/widgets/form_screen/payment_option_tile.dart';
import 'package:test/view/widgets/form_screen/total_tile.dart';
import 'package:test/view/widgets/register_hint_tile.dart';
import 'package:test/view/widgets/terms_apply.dart';

class Step7 extends StatefulWidget {
  const Step7({super.key});

  @override
  State<Step7> createState() => _Step7State();
}

class _Step7State extends State<Step7> with SingleTickerProviderStateMixin {
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
        listener: (context, state) {
          if (state is PostAllReuestsScucess) {
            cubit.postPayment(
                request: PaymentRequest(
                    cardNumber: cubit.cardNumberController.text,
                    expDate: cubit.expiryDateController.text,
                    cvv: cubit.cvvController.text,
                    cardHolder: cubit.cardHolderController.text));
          }
        },
        builder: (context, state) {
          return Form(
            key: cubit.formKey7,
            child: Column(
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
                      title: 'formHint7',
                      color: Colors.green,
                    ),
                  ),
                ),
                SizedBox(height: ratio * 10),
                const TotalTile(),
                SizedBox(height: ratio * 20),
                const PaymentOptionTile(),
                SizedBox(height: ratio * 10),
                CustomTextFormField(
                  controller: cubit.cardNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'cardNumber'.tr();
                    }
                    if (value.length < 16) {
                      return 'cardNumber'.tr();
                    }
                    return null;
                  },
                  label: 'cardNumber',
                  maxLen: 16,
                  prefixIcon: const Icon(Icons.lock_open_rounded),
                  required: true,
                ),
                SizedBox(height: ratio * 10),
                CustomTextFormField(
                  controller: cubit.expiryDateController,
                  label: 'expiryDate'.tr(),
                  required: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'expiryDate'.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: ratio * 10),
                CustomTextFormField(
                  controller: cubit.cvvController,
                  label: 'cvv',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'cvv'.tr();
                    }
                    if (value.length < 3) {
                      return 'cvv'.tr();
                    }
                    return null;
                  },
                  maxLen: 3,
                  required: true,
                ),
                SizedBox(height: ratio * 10),
                CustomTextFormField(
                  controller: cubit.cardHolderController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'cardHolder'.tr();
                    }
                    return null;
                  },
                  label: 'cardHolder',
                  required: true,
                ),
                SizedBox(height: ratio * 10),
                TermsApplyTextWidget(
                  interact: true,
                  agree: cubit.agreeToTerms,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
