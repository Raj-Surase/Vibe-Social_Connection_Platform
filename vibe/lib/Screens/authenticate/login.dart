import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Components/customsnackbar.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      // If the login is successful, navigate to the Home screen
      context.go('/navigator/home');
    } catch (e) {
      // Handle error (e.g., show a snackbar or dialog)
      ScaffoldMessenger.of(context).showSnackBar(
        createSnackBar("Error: $e"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(ValuesConstants.paddingLR),
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
                  controller: usernameController,
                  isSecure: false),
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
                  isSecure: true),
              const SizedBox(
                height: ValuesConstants.paddingTB,
              ),
              GestureDetector(
                onTap: (() {
                  context.replace('/register');
                }),
                child: Text(
                  "Don't have an account? Sign up.",
                  style: AppTypography.textStyle10Link(
                      color: AppColor.primaryButton),
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
                        WidgetStatePropertyAll(AppColor.primaryButton),
                  ),
                  child: Text(
                    'Login',
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
