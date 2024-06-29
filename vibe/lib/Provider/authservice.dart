
//THIS CODE HAS NEVER BEEN USER. JUST KEPT FOR BACKUP PURPOSE.

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vibe/provider/user_provider.dart';

// class AuthService {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   // Sign up with email and password
//   Future<User?> signUpWithEmailAndPassword(
//       BuildContext context, String email, String password) async {
//     try {
//       UserCredential result = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       User? user = result.user;
//       if (user != null) {
//         Provider.of<UserProvider>(context, listen: false)
//             .signIn(email, password);
//       }
//       return user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   // Sign in with email and password
//   Future<User?> signInWithEmailAndPassword(
//       BuildContext context, String email, String password) async {
//     try {
//       UserCredential result = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       User? user = result.user;
//       if (user != null) {
//         Provider.of<UserProvider>(context, listen: false)
//             .signIn(email, password);
//       }
//       return user;
//     } catch (e) {
//       print(e.toString());
//       return null;
//     }
//   }

//   // Sign out
//   Future<void> signOut(
//       BuildContext context, String email, String password) async {
//     try {
//       await _auth.signOut();
//       Provider.of<UserProvider>(context, listen: false).signOut();
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
