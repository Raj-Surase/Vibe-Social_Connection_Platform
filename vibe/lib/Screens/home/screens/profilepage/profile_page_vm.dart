import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:vibe/provider/user_provider.dart';

class ProfilePageViewModel extends ChangeNotifier {
  late Future<Map<String, dynamic>?> userFuture;
  final thumbIcon = MaterialStateProperty.all<Icon?>(null);
  bool light = false;
  bool light1 = false;

  void initialise(BuildContext context) {
    userFuture = _fetchUserData();
    notifyListeners();
  }

  Future<Map<String, dynamic>?> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirestoreService firestoreService = FirestoreService();
      return await firestoreService.getUser(user.uid);
    }
    return null;
  }

  void signOut(BuildContext context, UserProvider userProvider) {
    FirebaseAuth.instance.signOut();
    userProvider.signOut();
    GoRouter.of(context).replace(AppRoutes.INITIALROUTE);
  }

  void toggleLight(bool value) {
    light = value;
    notifyListeners();
  }

  void toggleLight1(bool value) {
    light1 = value;
    notifyListeners();
  }
}
