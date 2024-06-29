import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Screens/authenticate/authentication_vm.dart';
import 'package:vibe/components/primary_button.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthenticationPageViewModel>.reactive(
        viewModelBuilder: () => AuthenticationPageViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.initialise(context);
        },
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(
                  ValuesConstants.paddingLR,
                  ValuesConstants.paddingTB,
                  ValuesConstants.paddingLR,
                  ValuesConstants.paddingTB),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Welcome!",
                      style: AppTypography.textStyle24Bold(
                          color: AppColor.textHighEm),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.containerSmallMedium,
                  ),
                  PrimaryButton(
                    icon: Icons.g_mobiledata_rounded,
                    text: "Sign in with Google",
                    color: AppColor.primaryButton,
                    onPressed: () {},
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  PrimaryButton(
                    icon: Icons.email_rounded,
                    text: "Sign in with Email",
                    color: AppColor.componentBorder,
                    onPressed: () {
                      viewModel.navigateToLogin(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
