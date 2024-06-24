import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/components/user_tab.dart';

class SessionActivity extends StatelessWidget {
  const SessionActivity({
    super.key,
    required this.sessionName,
    required this.username,
  });

  final String sessionName;
  final String username;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push(AppRoutes.SESSIONACTIVITYROUTE, extra: sessionName);
      },
      child: Column(
        children: [
          Container(
            height: ValuesConstants.containerLarge,
            decoration: BoxDecoration(
              color: AppColor.surfaceFG,
              borderRadius: BorderRadius.circular(ValuesConstants.radiusLarge),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: ValuesConstants.paddingSmall),
            child: UserTab(
                title: "sessionName", subtitle: "username", isClickable: false),
          ),
        ],
      ),
    );
  }
}
