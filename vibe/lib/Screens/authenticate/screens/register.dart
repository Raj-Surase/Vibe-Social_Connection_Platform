import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:vibe/Provider/userprovider.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await Provider.of<UserProvider>(context, listen: false).signUp(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirestoreService firestoreService = FirestoreService();
        Map<String, dynamic>? userData =
            await firestoreService.getUser(user.uid);

        if (userData == null ||
            userData['user_name'] == null ||
            userData['user_profile'] == null) {
          context.replace(AppRoutes.PROFILEINITROUTE);
        } else {
          context.replace(AppRoutes.HOMEROUTE);
        }
      }
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
                  "Register",
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
              CustomTextField(
                hintText: "Email Address",
                controller: usernameController,
                isEmail: true,
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
              CustomTextField(
                hintText: "Password",
                controller: passwordController,
                isSecure: true,
              ),
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
              CustomTextField(
                hintText: "Confirm Password",
                controller: confirmpasswordController,
                isSecure: true,
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
                        MaterialStateProperty.all(AppColor.primaryButton),
                  ),
                  child: Text(
                    'Register',
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
                  context.replace(AppRoutes.LOGINROUTE);
                },
                child: Text(
                  "Already have an account? Login.",
                  style: AppTypography.textStyle12Bold(
                    color: AppColor.primaryButton,
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
