import "package:firebase_auth/firebase_auth.dart";
import "package:vibe/Components/dialogbox.dart";
import "package:vibe/Screens/home_page.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:vibe/Styles/colors.dart";
import "package:vibe/Styles/typography.dart";
import "package:vibe/authentication/login_ui.dart";

import "../Application/Authentication/auth_events.dart";
import "../Application/Authentication/auth_state_controller.dart";
import "../Application/Authentication/auth_states.dart";
import "../Services/Authentication/firebase_auth_facade.dart";
import "../Screens/Utils/custom_snackbar.dart";

final loginProvider =
    StateNotifierProvider.autoDispose<AuthStateController, AuthStates>((ref) {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseAuthFacade = FirebaseAuthFacade(firebaseAuth);
  return AuthStateController(firebaseAuthFacade);
});

class LoginPage extends HookConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formStates = ref.watch(loginProvider);
    final formEvents = ref.watch(loginProvider.notifier);
    ref.listen<AuthStates>(loginProvider, (previous, next) {
      next.authFailureOrSuccess.fold(
        () {},
        (either) => either.fold(
          (failure) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogBox(
                    color: AppColor.componentError,
                    text: Text(
                      "Invalid Login",
                      style: AppTypography.textStyle14Error,
                    ),
                  );
                });
          },
          (success) {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogBox(
                    color: AppColor.primaryButton,
                    text: Text(
                      "Login successfull",
                      style: AppTypography.textStyle14Error,
                    ),
                  );
                });
            Navigator.push<Widget>(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ));
          },
        ),
      );
    });
    return LoginUI(context, formEvents, formStates, formKey);
  }
}
