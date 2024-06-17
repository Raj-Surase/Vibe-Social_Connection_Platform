import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vibe/Components/sessionactivity.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

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
        children: [
          SessionActivity(sessionName: "sessionName", username: "username"),
          SizedBox(
            height: ValuesConstants.paddingTB,
          ),
          SessionActivity(sessionName: "Music", username: "username"),
          // Center(
          //   child: FutureBuilder<String>(
          //     future: _imageUrl,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return CircularProgressIndicator();
          //       } else if (snapshot.hasError) {
          //         return Text(
          //           'Error: ${snapshot.error}',
          //           style: AppTypography.textStyle14Bold(
          //               color: AppColor.textHighEm),
          //         );
          //       } else {
          //         return Image.network(snapshot.data!);
          //       }
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
