import 'package:flutter/material.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Screens/authenticate/login.dart';
// import 'package:vibe/Services/auth_service.dart';
// import 'package:vibe/Services/database_service.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';
// import 'package:vibe/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: ValuesConstants.ratioOneForth(context),
            // ),
            Center(
              child: Text(
                "Register",
                style: AppTypography.textStyle24Bold,
              ),
            ),
            const SizedBox(
              height: ValuesConstants.containerSmallMedium,
            ),

            Text(
              "Email id",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(hintText: "Email Address", isSecure: true),

            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            Text(
              "Password",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(hintText: "Password", isSecure: true),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            Text(
              "Confirm Password",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(hintText: "Confirm Password", isSecure: true),
            TextButton(
              onPressed: (() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              }),
              child: Text(
                "Already have an account? Sign in.",
                style: AppTypography.textStyle10Link,
              ),
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            SizedBox(
              width: ValuesConstants.screenWidth(context),
              height: ValuesConstants.containerSmallMedium,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColor.primaryButton),
                ),
                child: Text(
                  'Register',
                  style: AppTypography.textStyle14Bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
