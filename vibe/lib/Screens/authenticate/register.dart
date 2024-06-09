import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Screens/authenticate/login.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Provider/userprovider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernamecontroller;
  late TextEditingController passwordcontroller;
  late TextEditingController confirmpasswordcontroller;

  @override
  void initState() {
    super.initState();
    usernamecontroller = TextEditingController();
    passwordcontroller = TextEditingController();
    confirmpasswordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
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
            Center(
              child: Text(
                "Register",
                style:
                    AppTypography.textStyle24Bold(color: AppColor.textHighEm),
              ),
            ),
            const SizedBox(
              height: ValuesConstants.containerSmallMedium,
            ),

            Text(
              "Email id",
              style: AppTypography.textStyle14Bold(color: AppColor.textHighEm),
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(
                hintText: "Email Address",
                controller: usernamecontroller,
                isSecure: true),

            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            Text(
              "Password",
              style: AppTypography.textStyle14Bold(color: AppColor.textHighEm),
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(
                hintText: "Password",
                controller: passwordcontroller,
                isSecure: true),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            Text(
              "Confirm Password",
              style: AppTypography.textStyle14Bold(color: AppColor.textHighEm),
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(
                hintText: "Confirm Password",
                controller: confirmpasswordcontroller,
                isSecure: true),
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
                style:
                    AppTypography.textStyle10Link(color: AppColor.textHighEm),
              ),
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
            SizedBox(
              width: ValuesConstants.screenWidth(context),
              height: ValuesConstants.containerSmallMedium,
              child: TextButton(
                onPressed: () {
                  final username = usernamecontroller.text;
                  if (username.isNotEmpty) {
                    Provider.of<UserProvider>(context, listen: false)
                        .login(username);
                    context.go(
                        '/navigator/home'); // Navigate to the home page within the navigator
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColor.primaryButton),
                ),
                child: Text(
                  'Register',
                  style:
                      AppTypography.textStyle14Bold(color: AppColor.textHighEm),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
