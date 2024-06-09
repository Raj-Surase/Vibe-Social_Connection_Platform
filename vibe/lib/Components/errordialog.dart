import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class ErrorDialogBox extends StatelessWidget {
  final String title;
  final String description;

  const ErrorDialogBox({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ValuesConstants.radiusMedium),
      ),
      backgroundColor: AppColor.surfaceFG,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: AppTypography.textStyle14Error,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: ValuesConstants.paddingTB),
            Text(
              description,
              style: AppTypography.textStyle10Bold,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: ValuesConstants.paddingLR),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                // padding: EdgeInsets.only(
                //     left: ValuesConstants.paddingTB,
                //     right: ValuesConstants.paddingTB,
                //     bottom: ValuesConstants.paddingTB),
                backgroundColor:
                    AppColor.componentActive, // Change button color as needed
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(ValuesConstants.radiusSmall),
                ),
              ),
              child: Text('Okay', style: AppTypography.textStyle14Bold),
            ),
          ],
        ),
      ),
    );
  }
}
