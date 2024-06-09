import 'package:flutter/material.dart';
import 'package:vibe/Components/usertab.dart';
import 'package:vibe/Styles/values.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: UserTab(
          title: "Raj Surase",
          subtitle: "subtitle",
          isClickable: true,
        ));
  }
}
