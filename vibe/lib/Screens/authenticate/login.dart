import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Pages/navigation.dart';
import 'package:vibe/Screens/authenticate/register.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Provider/userprovider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernamecontroller;
  late TextEditingController passwordcontroller;

  @override
  void initState() {
    super.initState();
    usernamecontroller = TextEditingController();
    passwordcontroller = TextEditingController();
  }

  @override
  void dispose() {
    usernamecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(ValuesConstants.paddingLR),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Login",
                style: AppTypography.textStyle24Bold,
              ),
            ),
            const SizedBox(
              height: ValuesConstants.containerSmallMedium,
            ),
            Text(
              "Email",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            AuthTextField(
                hintText: "Email Address",
                controller: usernamecontroller,
                isSecure: false),
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
            AuthTextField(
                hintText: "Password",
                controller: passwordcontroller,
                isSecure: true),
            TextButton(
              onPressed: (() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterPage(),
                    ));
              }),
              child: Text(
                "Don't have an account? Sign up.",
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
                  'Login',
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
