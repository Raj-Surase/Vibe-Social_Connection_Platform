import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Components/sessionactivity.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Provider/userprovider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (!userProvider.isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(context).replace('/auth'); // Navigate to auth page
        });
        return Container(); // Return an empty container while redirecting
      }

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
    });
  }
}
