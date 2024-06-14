import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final String location =
      router.routerDelegate.currentConfiguration.uri.toString();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            // User is authenticated, navigate to HomePage
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (location != '/navigator/home') {
                context.go('/navigator/home');
              }
            });
          } else {
            // User is not authenticated, navigate to Authenticate
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (location != '/auth') {
                context.go('/auth');
              }
            });
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              "Error occurred",
              style:
                  AppTypography.textStyle24Bold(color: AppColor.componentError),
            ),
          );
        }
        // Show a loading spinner while checking the authentication state
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
