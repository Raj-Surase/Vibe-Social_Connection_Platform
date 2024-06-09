import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.hintText,
    required this.isSecure,
    required this.controller,
    this.isEnabled,
    super.key,
  });

  final String hintText;
  final bool? isEnabled;
  final TextEditingController controller;
  final bool isSecure;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isSecure,
      textInputAction: TextInputAction.next,
      cursorRadius: const Radius.circular(10),
      cursorColor: AppColor.componentActive,
      style: AppTypography.textStyle14Normal(color: AppColor.textLowEm),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        labelText: widget.hintText,
        fillColor: AppColor.surfaceFG,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle:
            AppTypography.textStyle14Inactive(color: AppColor.textHighEm),
        errorStyle:
            AppTypography.textStyle12Error(color: AppColor.componentError),
        border: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(ValuesConstants.radiusSmall)),
        ),
      ),
      enabled: widget.isEnabled ?? true,
    );
  }
}
