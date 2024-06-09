import 'package:flutter/material.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final String? alternativeText;
  final Function() onTap;

  final String? buttonText2;
  final String? alternativeText2;
  final Function()? onTap2;

  const CustomButton({
    super.key,
    required this.buttonText,
    this.alternativeText,
    required this.onTap,
    this.buttonText2,
    this.alternativeText2,
    this.onTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: ValuesConstants.screenWidth(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ValuesConstants.radiusLarge),
              color: AppColor.surfaceFG,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  buttonText,
                  style: AppTypography.textStyle10Bold,
                ),
                Text(
                  alternativeText!,
                  style: AppTypography.textStyle10Bold,
                ),
              ],
            ),
          ),
        ),
        if (buttonText2 != null)
          Padding(
            padding: const EdgeInsets.all(ValuesConstants.paddingSmall),
            child: Divider(
              color: AppColor.surfaceBG,
            ),
          ),
        InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                buttonText2!,
                style: AppTypography.textStyle10Bold,
              ),
              Text(
                alternativeText2!,
                style: AppTypography.textStyle10Bold,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
