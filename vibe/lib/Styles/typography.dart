import 'package:flutter/material.dart';
import 'package:vibe/Styles/colors.dart';

class AppTypography {
  static const TextStyle textStyle24Bold = TextStyle(
    color: AppColor.textHighEm,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle textStyle14Bold = TextStyle(
    color: AppColor.textHighEm,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle textStyle14Normal = TextStyle(
    color: AppColor.textLowEm,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textStyle14Inactive = TextStyle(
    color: Color.fromARGB(255, 112, 112, 112),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle textStyle10Link = TextStyle(
      fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.primaryButton);
  static const TextStyle textStyle10Bold = TextStyle(
      fontSize: 10, fontWeight: FontWeight.w600, color: AppColor.textHighEm);
  static const TextStyle textStyle8Normal = TextStyle(
      fontSize: 8, fontWeight: FontWeight.w500, color: AppColor.textLowEm);
}
