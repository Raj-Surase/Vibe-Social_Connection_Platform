import 'package:flutter/material.dart';
import 'package:vibe/Components/customtextfield.dart';
import 'package:vibe/Screens/login.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _userLoginController;
  late TextEditingController _userPasswordController;
  late TextEditingController _userEmailController;
  late TextEditingController _userConfirmPassController;

  @override
  void initState() {
    super.initState();
    _userLoginController = TextEditingController();
    _userPasswordController = TextEditingController();
    _userEmailController = TextEditingController();
    _userConfirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    _userLoginController = TextEditingController();
    _userPasswordController = TextEditingController();
    _userEmailController = TextEditingController();
    _userConfirmPassController = TextEditingController();

    super.dispose();
  }

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
            const Center(
              child: Text(
                "Register",
                style: AppTypography.textStyle24Bold,
              ),
            ),
            const SizedBox(
              height: ValuesConstants.containerSmallMedium,
            ),
            const Text(
              "User Name",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(ValuesConstants.radiusLarge),
                color: AppColor.surfaceFG,
                border: Border.all(color: AppColor.componentBorder),
              ),
              padding: const EdgeInsets.only(
                  left: ValuesConstants.paddingTB,
                  right: ValuesConstants.paddingTB),
              child: CustomTextField(
                  textFieldController: _userLoginController,
                  hintText: "Username"),
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            const Text(
              "Email id",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(ValuesConstants.radiusLarge),
                color: AppColor.surfaceFG,
                border: Border.all(color: AppColor.componentBorder),
              ),
              padding: const EdgeInsets.only(
                  left: ValuesConstants.paddingTB,
                  right: ValuesConstants.paddingTB),
              child: CustomTextField(
                  textFieldController: _userEmailController,
                  hintText: "Email id"),
            ),

            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            const Text(
              "Password",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(ValuesConstants.radiusLarge),
                color: AppColor.surfaceFG,
                border: Border.all(color: AppColor.componentBorder),
              ),
              padding: const EdgeInsets.only(
                  left: ValuesConstants.paddingTB,
                  right: ValuesConstants.paddingTB),
              child: CustomTextField(
                  textFieldController: _userPasswordController,
                  hintText: "Password"),
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            const Text(
              "Confirm Password",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(ValuesConstants.radiusLarge),
                color: AppColor.surfaceFG,
                border: Border.all(color: AppColor.componentBorder),
              ),
              padding: const EdgeInsets.only(
                  left: ValuesConstants.paddingTB,
                  right: ValuesConstants.paddingTB),
              child: CustomTextField(
                  textFieldController: _userConfirmPassController,
                  hintText: "Confirm Password"),
            ),
            TextButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              }),
              child: const Text(
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
                onPressed: (() {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => LoginPage(),
                  //     ));
                }),
                style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColor.primaryButton),
                ),
                child: const Text(
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
