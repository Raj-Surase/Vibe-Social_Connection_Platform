import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Components/customsnackbar.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    super.dispose();
  }

  Future<void> signUp(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordController.text.trim() !=
        confirmpasswordController.text.trim()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(createSnackBar("Password do not match."));
      return;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      // If the registration is successful, navigate to the Home screen
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
              Text(
                "Confirm Password",
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
              ),
              const SizedBox(
                height: ValuesConstants.paddingSmall,
              ),
              AuthTextField(
                  hintText: "Confirm Password",
                  controller: confirmpasswordController,
                  isSecure: true),
              const SizedBox(
                height: ValuesConstants.paddingTB,
              ),
              GestureDetector(
                onTap: (() {
                  context.replace('/login');
                }),
                child: Text(
                  "Already have an account? Sign in.",
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
                  onPressed: () => signUp(context),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColor.primaryButton),
                  ),
                  child: Text(
                    'Register',
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
