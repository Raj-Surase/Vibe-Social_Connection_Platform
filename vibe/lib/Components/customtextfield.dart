import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    required this.textFieldController,
    required this.hintText,
    this.isEnabled,
    super.key,
  });

  final TextEditingController textFieldController;
  final String hintText;
  final bool? isEnabled;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textFieldController,
      style: AppTypography.textStyle14Bold(color: AppColor.textHighEm),
      enabled: widget.isEnabled,
      cursorRadius: const Radius.circular(ValuesConstants.radiusSmall),
      cursorColor: AppColor.componentActive,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTypography.textStyle14Inactive(color: AppColor.textLowEm),
        disabledBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        // fillColor: AppColor.surfaceFG,
        // filled: true,
      ),
    );
  }
}
