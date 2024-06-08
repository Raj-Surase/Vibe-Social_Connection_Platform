import "package:flutter/material.dart";
import "package:vibe/Styles/colors.dart";
import "package:vibe/Styles/values.dart";

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildCustomSnackBar({
  required BuildContext context,
  required Color flashBackground,
  required Text content,
  required IconData icon,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: AppColor.componentBorder,
      duration: Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.fromLTRB(
          ValuesConstants.paddingLR,
          ValuesConstants.paddingTB,
          ValuesConstants.paddingLR,
          ValuesConstants.paddingTB),
      content: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ValuesConstants.radiusMedium),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: flashBackground,
              ),
              const SizedBox(
                width: 20,
              ),
              content
            ],
          ),
        ),
      )));
}
