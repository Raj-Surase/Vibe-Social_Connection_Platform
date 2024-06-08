import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:vibe/Styles/colors.dart";

import "authentication/login_bl.dart";

class FirebaseAuthenticationDDD extends StatelessWidget {
  const FirebaseAuthenticationDDD({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: kDebugMode,
      theme: ThemeData(
        brightness: Brightness.light,
        /* light theme settings */
        scaffoldBackgroundColor: AppColor.surfaceBG,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.surfaceBG,
          centerTitle: false,
        ),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: AppColor.surfaceBG,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.surfaceBG,
          centerTitle: false,
        ),
      ),
      themeMode: ThemeMode.light,
      home: LoginPage(),
    );
  }
}
