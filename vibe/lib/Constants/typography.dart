import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibe/Constants/colors.dart';

class AppTypography {
  static TextStyle textStyle24Bold({Color? color}) {
    return GoogleFonts.montserrat(
      color: color ?? AppColor.textHighEm,
      fontSize: 24,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle textStyle14Bold({Color? color}) {
    return GoogleFonts.montserrat(
      color: color ?? AppColor.textHighEm,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textStyle14Normal({Color? color}) {
    return GoogleFonts.montserrat(
      color: color ?? AppColor.textLowEm,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle14Error({Color? color}) {
    return GoogleFonts.montserrat(
      color: color ?? AppColor.componentError,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle14Inactive({Color? color}) {
    return GoogleFonts.montserrat(
      color: color ?? const Color.fromARGB(255, 112, 112, 112),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle12Error({Color? color}) {
    return GoogleFonts.montserrat(
      color: color ?? AppColor.componentError,
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle10Link({Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: color ?? AppColor.primaryButton,
    );
  }

  static TextStyle textStyle10Bold({Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: color ?? AppColor.textHighEm,
    );
  }

  static TextStyle textStyle8Normal({Color? color}) {
    return GoogleFonts.montserrat(
      fontSize: 8,
      fontWeight: FontWeight.w500,
      color: color ?? AppColor.textLowEm,
    );
  }
}
