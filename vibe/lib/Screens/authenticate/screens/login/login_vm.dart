import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:vibe/provider/user_provider.dart';

class LoginViewModel extends ChangeNotifier {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  void initialise() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> signIn(BuildContext context) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await Provider.of<UserProvider>(context, listen: false).signIn(
        emailController.text.trim(),
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

  void navigateToReset(BuildContext context) {
    context.go(AppRoutes.RESETROUTE);
  }

  void navigateToRegister(BuildContext context) {
    context.replace(AppRoutes.REGISTERROUTE);
  }

  void fillCredentials(String email, String password) {
    emailController.text = email;
    passwordController.text = password;
  }
}
