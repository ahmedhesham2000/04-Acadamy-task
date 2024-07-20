import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/controller/const.dart';
import 'package:test/controller/cubit/app_cubit.dart';

class TermsApplyTextWidget extends StatelessWidget {
  const TermsApplyTextWidget({
    super.key,
    this.agree,
    required this.interact,
  });
  final bool interact;
  final bool? agree;

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Row(
          children: [
            if (interact)
              SizedBox(
                width: ratio * 40,
                height: ratio * 40,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Checkbox(
                    value: agree,
                    activeColor: Colors.green,
                    isError: !cubit.agreeToTerms,
                    onChanged: (value) {
                      cubit.setAgreeToTerms(value ?? false);
                    },
                  ),
                ),
              ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'I agree to the'.tr(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: textSize * 14,
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    TextSpan(
                      text: ' ${'terms and conditions'.tr()}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: textSize * 14,
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
