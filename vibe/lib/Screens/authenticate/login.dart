import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Provider/userprovider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await Provider.of<UserProvider>(context, listen: false).signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      context.replace('/profileinit');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
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
              Center(
                child: Text(
                  "Login",
                  style:
                      AppTypography.textStyle24Bold(color: AppColor.textHighEm),
                ),
              ),
              const SizedBox(
                height: ValuesConstants.containerSmallMedium,
              ),
              Text(
                "Email",
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
              ),
              const SizedBox(
                height: ValuesConstants.paddingSmall,
              ),
              AuthTextField(
                hintText: "Email Address",
                controller: emailController,
                isSecure: false,
              ),
              const SizedBox(
                height: ValuesConstants.paddingTB,
              ),
              Text(
                "Password",
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
              ),
              const SizedBox(
                height: ValuesConstants.paddingSmall,
              ),
              AuthTextField(
                hintText: "Password",
                controller: passwordController,
                isSecure: true,
              ),
              const SizedBox(
                height: ValuesConstants.paddingTB,
              ),
              GestureDetector(
                onTap: () {
                  context.go('/reset_password');
                },
                child: Text(
                  "Forgot password?",
                  style: AppTypography.textStyle12Bold(
                    color: AppColor.primaryButton,
                  ),
                ),
              ),
              const SizedBox(
                height: ValuesConstants.paddingTB,
              ),
              SizedBox(
                width: ValuesConstants.screenWidth(context),
                height: ValuesConstants.containerSmallMedium,
                child: TextButton(
                  onPressed: () => signIn(context),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColor.primaryButton),
                  ),
                  child: Text(
                    'Login',
                    style: AppTypography.textStyle14Bold(
                      color: AppColor.textHighEm,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: ValuesConstants.paddingTB,
              ),
              GestureDetector(
                onTap: () {
                  context.replace('/register');
                },
                child: Text(
                  "Don't have an account? Sign up.",
                  style: AppTypography.textStyle12Bold(
                    color: AppColor.primaryButton,
                  ),
                ),
              ),
              const SizedBox(
                height: ValuesConstants.containerMedium,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      emailController.text = "rajsurase3@gmail.com";
                      passwordController.text = "larick434";
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: ValuesConstants.screenWidth(context) * 0.08,
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  GestureDetector(
                    onTap: () {
                      emailController.text = "r@gmail.com";
                      passwordController.text = "larick434";
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: ValuesConstants.screenWidth(context) * 0.08,
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  GestureDetector(
                    onTap: () {
                      emailController.text = "rajsurase70@gmail.com";
                      passwordController.text = "larick434";
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: ValuesConstants.screenWidth(context) * 0.08,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
