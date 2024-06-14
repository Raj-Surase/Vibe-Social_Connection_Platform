import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Components/auth_tf.dart';
import 'package:vibe/Components/customsnackbar.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  final TextEditingController emailId = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> forgotPass(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailId.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        createSnackBar("Password reset email sent!"),
      );
      context.pop();
    } catch (e) {
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
        appBar: AppBar(
          leadingWidth: ValuesConstants.containerMediumLarge,
          leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.textHighEm,
              size: ValuesConstants.iconSize,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(ValuesConstants.paddingLR),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "Reset Password",
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
                controller: emailId,
                isSecure: false,
              ),
              const SizedBox(
                height: ValuesConstants.containerSmall,
              ),
              SizedBox(
                width: ValuesConstants.screenWidth(context),
                height: ValuesConstants.containerSmallMedium,
                child: TextButton(
                  onPressed: () => forgotPass(context),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(AppColor.primaryButton),
                  ),
                  child: Text(
                    'Reset Password',
                    style: AppTypography.textStyle14Bold(
                      color: AppColor.textHighEm,
                    ),
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
