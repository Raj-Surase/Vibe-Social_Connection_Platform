import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:vibe/provider/user_provider.dart';

class RegisterViewModel extends ChangeNotifier {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  late TextEditingController confirmpasswordController;
  final formKey = GlobalKey<FormState>();

  void initialise() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    confirmpasswordController = TextEditingController();
  }

  void disposeControllers() {
    usernameController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
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

  void navigateToLogin(BuildContext context) {
    context.replace(AppRoutes.LOGINROUTE);
  }
}
