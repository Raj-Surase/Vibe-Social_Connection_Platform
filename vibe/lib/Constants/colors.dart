import "package:flutter/material.dart";

class AppColor {
  // AppColor({Key? key, required this.isLight});
  static bool isLight = false;
  static Color surfaceBG =
      isLight ? const Color(0xffe8e9e9) : const Color(0xff171616);
  static Color surfaceFG =
      isLight ? const Color(0xffe1e1e1) : const Color(0xff1E1E1E);
  static Color componentActive =
      isLight ? const Color(0xffE699F2) : const Color(0xffE699F2);
  static Color componentInactive =
      isLight ? const Color(0xffF2E8F3) : const Color(0xffF2E8F3);
  static Color componentError = isLight
      ? const Color.fromARGB(255, 255, 62, 62)
      : const Color.fromARGB(255, 255, 62, 62);
  static Color textHighEm =
      isLight ? const Color(0xff111a0c) : Color.fromARGB(255, 243, 241, 244);
  static Color textLowEm =
      isLight ? const Color(0xff191919) : Color.fromARGB(255, 218, 214, 214);
  static Color primaryButton = isLight
      ? const Color.fromARGB(255, 73, 158, 255)
      : const Color.fromARGB(255, 73, 158, 255);
  static Color componentBorder =
      isLight ? const Color(0xff171616) : const Color(0xff454146);

//     Color(0xffe8e9e9);
//   Color(0xffe1e1e1);
// Color(0xffE699F2);
//  Color(0xffF2E8F3);
// Color.fromARGB(255, 255, 62, 62);
// Color(0xff111a0c);
// Color(0xff191919);
//   Color.fromARGB(255, 73, 158, 255);
//   Color(0xff171616) : Color(0xffbabeb9);
}
