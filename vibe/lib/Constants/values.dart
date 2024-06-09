import 'package:flutter/material.dart';

class ValuesConstants {
  static const double radiusSmall = 8;
  static const double radiusMedium = 10;
  static const double radiusLarge = 14;
  static const double radiusCircle = 200;

  static const double containerSmall = 30;
  static const double containerSmallMedium = 40;
  static const double containerMedium = 60;
  static const double containerMediumLarge = 80;
  static const double containerLarge = 200;

  static const double paddingLR = 24;
  static const double paddingTB = 12;
  static const double paddingSmall = 5;

  static const double spaceVertical = 20;

  static const double iconSize = 24;

  static double ratioOneForth(BuildContext context) {
    return MediaQuery.of(context).size.height / 4;
  }

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
