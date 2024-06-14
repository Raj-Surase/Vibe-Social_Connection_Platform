import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Components/auhbutton.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

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
        padding: const EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Welcome!",
                style:
                    AppTypography.textStyle24Bold(color: AppColor.textHighEm),
              ),
            ),
            const SizedBox(
              height: ValuesConstants.containerSmallMedium,
            ),
            AuthButton(
              icon: Icons.g_mobiledata_rounded,
              text: "Sign in with Google",
              color: AppColor.primaryButton,
              onPressed: () {},
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            AuthButton(
              icon: Icons.email_rounded,
              text: "Sign in with Email",
              color: AppColor.componentBorder,
              onPressed: () {
                context.push('/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
