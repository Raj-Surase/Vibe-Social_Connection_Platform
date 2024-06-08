import 'package:flutter/material.dart';
import 'package:vibe/Application/Authentication/auth_events.dart';
import 'package:vibe/Application/Authentication/auth_state_controller.dart';
import 'package:vibe/Application/Authentication/auth_states.dart';

SafeArea LoginUI(BuildContext context, AuthStateController formEvents,
    AuthStates formStates, GlobalKey<FormState> formKey) {
  return SafeArea(
    child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
          elevation: 5,
          leading: const Icon(
            Icons.login_rounded,
            size: 25,
          ),
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
          centerTitle: false,
        ),
        body: SizedBox.expand(
          child: Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                reverse: true,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome !",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "Login or Signup to continue",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) => formEvents.mapEventsToStates(
                          AuthEvents.emailChanged(email: value.toString())),
                      validator: (value) =>
                          formStates.emailAddress.valueObject!.fold(
                        (failure) => failure!.maybeMap(
                            orElse: () => null,
                            invalidEmail: (value) => "Invalid email"),
                        (r) => null,
                      ),
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      decoration: const InputDecoration(
                        labelText: "Email Address",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () =>
                          FocusScope.of(context).nextFocus(),
                      validator: (value) =>
                          formStates.password.valueObject!.fold(
                        (failure) => failure!.maybeMap(
                          orElse: () => null,
                          shortPassword: (value) => "Very short password",
                          noUpperCase: (value) =>
                              "Must contain an uppercase character",
                          noNumber: (value) => "Must contain a number",
                          noSpecialSymbol: (value) =>
                              "Must contain a special character",
                        ),
                        (r) => null,
                      ),
                      onChanged: (value) => formEvents.mapEventsToStates(
                        AuthEvents.passwordChanged(password: value.toString()),
                      ),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formEvents.mapEventsToStates(
                                    const AuthEvents
                                        .signInWithEmailAndPasswordPressed(),
                                  );
                                }
                              },
                              child: const Text("Login"),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 55,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  textStyle:
                                      Theme.of(context).textTheme.titleLarge,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  formEvents.mapEventsToStates(
                                    const AuthEvents
                                        .signUpWithEmailAndPasswordPressed(),
                                  );
                                }
                              },
                              child: const Text("Sign Up"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (formStates.isSubmitting) ...[
                      const SizedBox(
                        height: 20,
                      ),
                      const LinearProgressIndicator(
                        minHeight: 6,
                      )
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
