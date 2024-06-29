import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/values.dart';

class HomePageViewModel extends ChangeNotifier {
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

  initialise(BuildContext context) {
    notifyListeners();
    initController();
  }

  void initController() {}

  void getUsers() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection('users').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc["user_name"]);
      });
    });
  }
}
