import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Provider/applinks_deeplinks.dart';
import 'package:vibe/Provider/platform_channel.dart';
import 'package:vibe/provider/user_provider.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/provider/list_provide.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AppLinksDeepLink.instance.initDeepLinks();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) => ListProvider()), // Add ListProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
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
      routerDelegate: AppRoutes.router.routerDelegate,
      routeInformationParser: AppRoutes.router.routeInformationParser,
      routeInformationProvider: AppRoutes.router.routeInformationProvider,
    );
  }
}
