import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:test/controller/const.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.label,
      required this.controller,
      this.required = false,
      this.validator,
      this.keyboardType = TextInputType.text,
      this.onTap,
      this.maxLen,
      this.hintText,
      this.enabled = true,
      this.prefixIcon,
      this.height = 15,
      this.suffixIcon});

  final String? label;
  final String? hintText;
  final bool required;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Function()? onTap;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int height;
  final int? maxLen;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
        // style: TextStyle(
        //   color: Colors.grey.shade500,
        //   fontSize: textSize * 16.0,
        // ),
        controller: controller,
        validator: validator,
        enabled: enabled,
        onTap: onTap,
        maxLength: maxLen,

        keyboardType: keyboardType,
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(
            horizontal: ratio * 10.0,
            vertical: ratio * height,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText?.tr(),
          hintMaxLines: 3,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: textSize * 16.0,
          ),
          label: label != null
              ? RichText(
                  text: TextSpan(
                    text: label!.tr(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: textSize * 16.0,
                    ),
                    children: [
                      if (required)
                        const TextSpan(
                          text: ' *',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                    ],
                  ),
                )
              : null,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(ratio * 5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(ratio * 5.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(ratio * 5.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(ratio * 5.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
            borderRadius: BorderRadius.circular(ratio * 5.0),
          ),
        ),
      ),
    );
  }
}
