import 'package:flutter/material.dart';
import 'package:vibe/Components/usertab.dart';
import 'package:vibe/Styles/values.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        ));
  }
}
