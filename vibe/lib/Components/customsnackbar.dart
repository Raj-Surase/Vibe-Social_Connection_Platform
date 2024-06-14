import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';

SnackBar createSnackBar(String message) {
  return SnackBar(
    content: Text(
      message,
      style: AppTypography.textStyle12Error(color: AppColor.textHighEm),
    ),
    backgroundColor: AppColor.componentError,
    behavior: SnackBarBehavior.floating,
    action: SnackBarAction(
      label: 'Dismiss',
      disabledTextColor: Colors.white,
      textColor: AppColor.textHighEm,
      onPressed: () {},
    ),
  );
}
