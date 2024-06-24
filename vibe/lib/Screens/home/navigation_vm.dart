import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:go_router/go_router.dart';
import 'package:vibe/Constants/values.dart';

class NavigatorPageViewModel extends ChangeNotifier {
  final _controller = ScrollController();
  late int _currentIndex = 0;
  int _backPress = 0;

  bool isLoading = false;
  ScrollController get controller => _controller;
  int get currentIndex => _currentIndex;
  int get backPress => _backPress;

  initialise(BuildContext context) {
    notifyListeners();
    initController();
  }

  currentIndexHome(int initialIndex) {
    _currentIndex = initialIndex;
  }

  void initController() {}

  void tabChange(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  void backPressCount(int value) {
    _backPress = value;
    notifyListeners();
  }

  late bool light = false;
  late bool light1 = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String imageUrl = "";

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(
          Icons.check,
          size: ValuesConstants.iconSize,
        );
      }
      return const Icon(
        Icons.close,
        size: ValuesConstants.iconSize,
      );
    },
  );
}
