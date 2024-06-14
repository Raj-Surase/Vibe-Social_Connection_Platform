import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Components/usertab.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Provider/userprovider.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (!userProvider.isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context).replace('/auth'); // Navigate to auth page
          });
          return Container(
            color: AppColor.surfaceBG,
          ); // Return an empty container while redirecting
        }
        return const Padding(
          padding: EdgeInsets.fromLTRB(
              ValuesConstants.paddingLR,
              ValuesConstants.paddingTB,
              ValuesConstants.paddingLR,
              ValuesConstants.paddingTB),
          child: UserTab(
            title: "sessionName",
            subtitle: "username",
            isClickable: false,
          ),
        );
      },
    );
  }
}
