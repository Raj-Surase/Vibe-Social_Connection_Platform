import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/components/custom_snackbar.dart';

class ResetPasswordViewModel extends ChangeNotifier {
  late TextEditingController emailId;
  final formKey = GlobalKey<FormState>();

  ResetPasswordViewModel() {
    emailId = TextEditingController();
  }

  @override
  void dispose() {
    emailId.dispose();
    super.dispose();
  }

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
}
