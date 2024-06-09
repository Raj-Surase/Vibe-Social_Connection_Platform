import 'package:flutter/material.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'Provider/userprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp.router(
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
        routerDelegate: router.routerDelegate,
        routeInformationParser: router.routeInformationParser,
        routeInformationProvider: router.routeInformationProvider,
      ),
    );
  }
}
