import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/provider/user_provider.dart';

class SessionViewModel extends ChangeNotifier {
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = List.filled(50, "Hello...");

  bool isLoggedIn(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false).isLoggedIn;
  }

  void redirectToLoginPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).replace(AppRoutes.INITIALROUTE);
    });
  }

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      messages.add(messageController.text);
      messageController.clear();
      notifyListeners();
    }
  }
}
