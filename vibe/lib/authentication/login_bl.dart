import "package:firebase_auth/firebase_auth.dart";
import "package:vibe/Screens/home_page.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
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
            buildCustomSnackBar(
                context: context,
                flashBackground: Colors.red,
                icon: Icons.warning_rounded,
                content: Text(
                  failure.maybeMap(
                      orElse: () => "",
                      emailAlreadyInUse: (value) => "User already exists",
                      serverError: (value) {
                        return "Server error occurred";
                      },
                      invalidEmailAndPasswordCombination: (value) {
                        return "Invalid email or password";
                      }),
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ));
          },
          (success) {
            buildCustomSnackBar(
                context: context,
                flashBackground: Colors.green,
                icon: CupertinoIcons.check_mark_circled_solid,
                content: Text(
                  "Login successful",
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: Colors.white),
                ));
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
