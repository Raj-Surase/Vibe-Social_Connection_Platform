import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/screens/authenticate/screens/register/register_vm.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        return Form(
          key: viewModel.formKey,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(
                ValuesConstants.paddingLR,
                ValuesConstants.paddingTB,
                ValuesConstants.paddingLR,
                ValuesConstants.paddingTB,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "Register",
                      style: AppTypography.textStyle24Bold(
                          color: AppColor.textHighEm),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.containerSmallMedium,
                  ),
                  Text(
                    "Email",
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingSmall,
                  ),
                  CustomTextField(
                    hintText: "Email Address",
                    controller: viewModel.usernameController,
                    isEmail: true,
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  Text(
                    "Password",
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingSmall,
                  ),
                  CustomTextField(
                    hintText: "Password",
                    controller: viewModel.passwordController,
                    isSecure: true,
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  Text(
                    "Confirm Password",
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingSmall,
                  ),
                  CustomTextField(
                    hintText: "Confirm Password",
                    controller: viewModel.confirmpasswordController,
                    isSecure: true,
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  SizedBox(
                    width: ValuesConstants.screenWidth(context),
                    height: ValuesConstants.containerSmallMedium,
                    child: TextButton(
                      onPressed: () => viewModel.signUp(context),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.primaryButton),
                      ),
                      child: Text(
                        'Register',
                        style: AppTypography.textStyle14Bold(
                            color: AppColor.textHighEm),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.navigateToLogin(context);
                    },
                    child: Text(
                      "Already have an account? Login.",
                      style: AppTypography.textStyle12Bold(
                        color: AppColor.primaryButton,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    Provider.of<RegisterViewModel>(context, listen: false).disposeControllers();
    super.dispose();
  }
}
