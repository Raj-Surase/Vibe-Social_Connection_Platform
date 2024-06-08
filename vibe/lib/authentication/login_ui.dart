import 'package:flutter/material.dart';
import 'package:vibe/Application/Authentication/auth_events.dart';
import 'package:vibe/Application/Authentication/auth_state_controller.dart';
import 'package:vibe/Application/Authentication/auth_states.dart';
import 'package:vibe/Components/dialogbox.dart';
import 'package:vibe/Screens/register.dart';
import 'package:vibe/Screens/utils/custom_snackbar.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

SafeArea LoginUI(BuildContext context, AuthStateController formEvents,
    AuthStates formStates, GlobalKey<FormState> formKey) {
  return SafeArea(
    child: GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(ValuesConstants.paddingLR),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   height: ValuesConstants.ratioOneForth(context),
                // ),
                Center(
                  child: Text(
                    "Login",
                    style: AppTypography.textStyle24Bold,
                  ),
                ),
                const SizedBox(
                  height: ValuesConstants.containerSmallMedium,
                ),
                Text(
                  "Email",
                  style: AppTypography.textStyle14Bold,
                ),
                const SizedBox(
                  height: ValuesConstants.paddingSmall,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) => formEvents.mapEventsToStates(
                      AuthEvents.emailChanged(email: value.toString())),
                  validator: (value) =>
                      formStates.emailAddress.valueObject!.fold(
                    (failure) => failure.maybeMap(
                        orElse: () => null,
                        invalidEmail: (value) => "Invalid email"),
                    (r) => null,
                  ),
                  textInputAction: TextInputAction.next,
                  cursorRadius: Radius.circular(10),
                  cursorColor: AppColor.componentActive,
                  style: AppTypography.textStyle14Normal,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    fillColor: AppColor.surfaceFG,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: AppTypography.textStyle14Inactive,
                    errorStyle: AppTypography.textStyle12Error,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(ValuesConstants.radiusSmall)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: ValuesConstants.paddingTB,
                ),
                Text(
                  "Password",
                  style: AppTypography.textStyle14Bold,
                ),
                const SizedBox(
                  height: ValuesConstants.paddingSmall,
                ),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  // validator: (value) => formStates.password.valueObject!.fold(
                  //   (failure) => failure.maybeMap(
                  //     orElse: () => null,
                  //     // shortPassword: (value) => "Very short password",
                  //     // noUpperCase: (value) =>
                  //     //     "Must contain an uppercase character",
                  //     // noNumber: (value) => "Must contain a number",
                  //     // noSpecialSymbol: (value) =>
                  //     //     "Must contain a special character",
                  //   ),
                  //   (r) => null,
                  // ),
                  onChanged: (value) => formEvents.mapEventsToStates(
                    AuthEvents.passwordChanged(password: value.toString()),
                  ),
                  cursorRadius: Radius.circular(10),
                  cursorColor: AppColor.componentActive,
                  style: AppTypography.textStyle14Normal,
                  decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: AppColor.surfaceFG,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelStyle: AppTypography.textStyle14Inactive,
                    errorStyle: AppTypography.textStyle12Error,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(ValuesConstants.radiusSmall)),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPage(),
                        ));
                  }),
                  child: Text(
                    "Don't have an account? Sign up.",
                    style: AppTypography.textStyle10Link,
                  ),
                ),
                const SizedBox(
                  height: ValuesConstants.paddingTB,
                ),
                SizedBox(
                  width: ValuesConstants.screenWidth(context),
                  height: ValuesConstants.containerSmallMedium,
                  child: TextButton(
                    onPressed: (() {
                      if (formKey.currentState!.validate()) {
                        formEvents.mapEventsToStates(
                          const AuthEvents.signInWithEmailAndPasswordPressed(),
                        );
                      }
                    }),
                    style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColor.primaryButton),
                    ),
                    child: Text(
                      'Login',
                      style: AppTypography.textStyle14Bold,
                    ),
                  ),
                ),
                // SizedBox(
                //   width: ValuesConstants.screenWidth(context),
                //   height: ValuesConstants.containerSmallMedium,
                //   child: TextButton(
                //     onPressed: (() {
                //       showDialog(
                //           context: context,
                //           builder: (BuildContext context) {
                //             return DialogBox(
                //               color: AppColor.componentError,
                //               text: Text(
                //                 "Invalid Login",
                //                 style: AppTypography.textStyle14Error,
                //               ),
                //             );
                //           });
                //     }),
                //     style: const ButtonStyle(
                //       backgroundColor:
                //           WidgetStatePropertyAll(AppColor.primaryButton),
                //     ),
                //     child: Text(
                //       'Test',
                //       style: AppTypography.textStyle14Bold,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
