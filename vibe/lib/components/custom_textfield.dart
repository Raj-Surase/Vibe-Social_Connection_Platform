import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.hintText,
    this.isSecure = false,
    this.isUsername,
    this.isEmail,
    required this.controller,
    this.isEnabled,
    Key? key,
  }) : super(key: key);

  final String hintText;
  final bool? isEnabled;
  final bool? isUsername;
  final bool? isEmail;
  final TextEditingController controller;
  final bool isSecure;

  @override
  State<CustomTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<CustomTextField> {
  String? _validateEmail(String? value) {
    if (!widget.isSecure && widget.isUsername != true) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Invalid email address';
      }
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (widget.isSecure) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters long';
      }
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (widget.isUsername == true) {
      if (value == null || value.isEmpty) {
        return 'Username is required';
      }
      if (!RegExp(r'^[a-zA-Z0-9\s]+$').hasMatch(value)) {
        return 'Username can only contain alphabets, numbers, and whitespace';
      }
    }
    return null;
  }

  String? _validateText(String? value) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isSecure,
      textInputAction: TextInputAction.next,
      autofocus: true,
      cursorRadius: const Radius.circular(10),
      cursorColor: AppColor.componentActive,
      style: AppTypography.textStyle14Normal(color: AppColor.textLowEm),
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.isSecure
          ? _validatePassword
          : widget.isUsername == true
              ? _validateUsername
              : widget.isEmail == true
                  ? _validateEmail
                  : _validateText,
      decoration: InputDecoration(
        labelText: widget.hintText,
        fillColor: AppColor.surfaceFG,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: AppTypography.textStyle14Normal(color: AppColor.textLowEm),
        errorStyle:
            AppTypography.textStyle12Bold(color: AppColor.componentError),
        border: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(ValuesConstants.radiusSmall)),
        ),
      ),
      enabled: widget.isEnabled ?? true,
    );
  }
}
