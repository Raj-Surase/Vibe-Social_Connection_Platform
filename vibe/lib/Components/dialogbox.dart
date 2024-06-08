import 'package:flutter/material.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class DialogBox extends StatelessWidget {
  DialogBox({super.key, required this.text, required this.color});

  Text text;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ValuesConstants.radiusLarge)),
      backgroundColor: AppColor.surfaceFG,
      child: Container(
        height: 300,
        padding: EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Spacer(),
            text,
            Spacer(),
            SizedBox(
              width: ValuesConstants.screenWidth(context) * 0.6,
              height: ValuesConstants.containerSmallMedium,
              child: TextButton(
                onPressed: (() {
                  Navigator.pop(context);
                }),
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColor.componentActive),
                ),
                child: Text(
                  'Close',
                  style: AppTypography.textStyle14Bold,
                ),
              ),
            ),
            SizedBox(
              height: ValuesConstants.paddingTB,
            )
          ],
        ),
      ),
    );
  }
}
