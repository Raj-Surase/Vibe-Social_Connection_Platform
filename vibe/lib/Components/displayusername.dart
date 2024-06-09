import 'package:flutter/material.dart';
import 'package:vibe/Constants/typography.dart';

class UsernameDisplayWidget extends StatelessWidget {
  const UsernameDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // UserModel? currentUser = AuthService.getUser()!.username
    //     as UserModel?; // Get the current user from AuthService

    String username = 'Guest'; // Get username or fallback to 'Guest'

    return Text(
      'Welcome, $username',
      style: AppTypography.textStyle14Bold,
    );
  }
}
