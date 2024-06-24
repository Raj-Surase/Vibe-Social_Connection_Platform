import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibe/Constants/colors.dart';

Future<bool> handleBackButtonPress(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      surfaceTintColor: AppColor.surfaceFG,
      backgroundColor: AppColor.surfaceBG,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Confirm Exit'),
      content: const Text('Are you sure you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            SystemNavigator.pop(); // This line exits the app directly
          },
          child: const Text('Yes'),
        ),
      ],
    ),
  );
  return true;
}
