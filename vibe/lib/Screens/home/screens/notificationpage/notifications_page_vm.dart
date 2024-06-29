import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/values.dart';

class NotificationsPageViewModel extends ChangeNotifier {
  final _controller = ScrollController();

  ScrollController get controller => _controller;

  bool isLoggedIn(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  void redirectToAuthPage(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      GoRouter.of(context).replace(AppRoutes.INITIALROUTE);
    });
  }

  void initialise(BuildContext context) {
    notifyListeners();
    initController();
  }

  void initController() {}
}
