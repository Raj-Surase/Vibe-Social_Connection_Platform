import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibe/Styles/colors.dart';

class AppTypography {
  static final TextStyle textStyle24Bold = GoogleFonts.montserrat(
    color: AppColor.textHighEm,
    fontSize: 24,
    fontWeight: FontWeight.w800,
  );

  static final TextStyle textStyle14Bold = GoogleFonts.montserrat(
    color: AppColor.textHighEm,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle textStyle14Normal = GoogleFonts.montserrat(
    color: AppColor.textLowEm,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textStyle14Error = GoogleFonts.montserrat(
    color: AppColor.componentError,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textStyle14Inactive = GoogleFonts.montserrat(
    color: Color.fromARGB(255, 112, 112, 112),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textStyle12Error = GoogleFonts.montserrat(
    color: AppColor.componentError,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle textStyle10Link = GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColor.primaryButton,
  );

  static final TextStyle textStyle10Bold = GoogleFonts.montserrat(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColor.textHighEm,
  );

  static final TextStyle textStyle8Normal = GoogleFonts.montserrat(
    fontSize: 8,
    fontWeight: FontWeight.w500,
    color: AppColor.textLowEm,
  );
}
