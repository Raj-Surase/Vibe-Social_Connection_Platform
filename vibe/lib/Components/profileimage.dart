import 'package:flutter/material.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/values.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ValuesConstants.containerSmall,
      width: ValuesConstants.containerSmall,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ValuesConstants.radiusCircle),
        color: AppColor.surfaceBG,
      ),
    );
  }
}
