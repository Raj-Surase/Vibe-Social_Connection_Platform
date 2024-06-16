import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Provider/userprovider.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final String location =
      router.routerDelegate.currentConfiguration.uri.toString();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (user != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (location != '/navigator/home') {
          context.go('/navigator/home');
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (location != '/auth') {
          context.go('/auth');
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