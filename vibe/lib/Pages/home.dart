// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:vibe/Components/sessionactivity.dart';
import 'package:vibe/Styles/values.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          ValuesConstants.paddingLR,
          ValuesConstants.paddingTB,
          ValuesConstants.paddingLR,
          ValuesConstants.paddingTB),
      child: Column(
        children: const [
          SessionActivity(sessionName: "sessionName", username: "username"),
          SizedBox(
            height: ValuesConstants.paddingTB,
          ),
          SessionActivity(sessionName: "Music", username: "username"),
        ],
      ),
    );
  }
}
