import 'package:flutter/material.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.hintText,
    required this.isSecure,
    this.isEnabled,
    super.key,
  });

  final String hintText;
  final bool? isEnabled;
  final bool isSecure;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: widget.isSecure,
      textInputAction: TextInputAction.next,
      cursorRadius: Radius.circular(10),
      cursorColor: AppColor.componentActive,
      style: AppTypography.textStyle14Normal,
      onEditingComplete: () => FocusScope.of(context).nextFocus(),
      decoration: InputDecoration(
        labelText: widget.hintText,
        fillColor: AppColor.surfaceFG,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelStyle: AppTypography.textStyle14Inactive,
        errorStyle: AppTypography.textStyle12Error,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(ValuesConstants.radiusSmall)),
        ),
      ),
      enabled: widget.isEnabled ?? true,
    );
  }
}
