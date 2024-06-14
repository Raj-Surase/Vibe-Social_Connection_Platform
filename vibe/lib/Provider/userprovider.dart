import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  bool get isLoggedIn => _user != null; // Getter to check if user is logged in

  UserProvider() {
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    _user = FirebaseAuth.instance.currentUser;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<void> signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e; // Consider throwing a custom exception here if needed
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw e; // Consider throwing a custom exception here with clear error messages
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e; // Consider throwing a custom exception here if needed
    }
  }

  @override
  void dispose() {
    // Unsubscribe from auth state changes when the provider is disposed
    FirebaseAuth.instance.authStateChanges().listen((User? user) {}).cancel();
    super.dispose();
  }
}
