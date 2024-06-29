import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Database/firestore_service.dart';
import 'package:vibe/provider/user_provider.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final String location =
      AppRoutes.router.routerDelegate.currentConfiguration.uri.toString();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FirestoreService firestoreService = FirestoreService();
        Map<String, dynamic>? userData =
            await firestoreService.getUser(user.uid);

        if (userData == null ||
            userData['user_name'] == null ||
            userData['user_profile'] == null) {
          if (location != AppRoutes.PROFILEINITROUTE) {
            context.go(AppRoutes.PROFILEINITROUTE);
          }
        } else {
          if (location != AppRoutes.HOMEROUTE) {
            context.go(AppRoutes.HOMEROUTE);
          }
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (location != AppRoutes.AUTHROUTE) {
          context.go(AppRoutes.AUTHROUTE);
        }
      });
    }

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
