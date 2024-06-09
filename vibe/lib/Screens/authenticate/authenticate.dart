import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Screens/authenticate/login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.g_mobiledata_rounded,
                    color: AppColor.textHighEm,
                    size: 24,
                  ),
                  Text(
                    "Google",
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
                  )
                ],
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColor.primaryButton),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusMedium),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
