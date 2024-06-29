import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../Constants/routes.dart';

class AuthenticationPageViewModel extends ChangeNotifier {
  initialise(BuildContext context) {
    notifyListeners();
    initController();
  }

  void initController() {}

  void navigateToLogin(BuildContext context) {
    context.push(AppRoutes.LOGINROUTE);
  }
}
