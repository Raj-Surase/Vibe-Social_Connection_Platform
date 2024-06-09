import 'package:flutter/material.dart';
import 'package:vibe/Screens/authenticate/login.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
