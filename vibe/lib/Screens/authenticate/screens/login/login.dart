import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/screens/authenticate/screens/login/login_vm.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                      "Login",
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
                    controller: viewModel.emailController,
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
                  GestureDetector(
                    onTap: () {
                      viewModel.navigateToReset(context);
                    },
                    child: Text(
                      "Forgot password?",
                      style: AppTypography.textStyle12Bold(
                        color: AppColor.primaryButton,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  SizedBox(
                    width: ValuesConstants.screenWidth(context),
                    height: ValuesConstants.containerSmallMedium,
                    child: TextButton(
                      onPressed: () => viewModel.signIn(context),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(AppColor.primaryButton),
                      ),
                      child: Text(
                        'Login',
                        style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  GestureDetector(
                    onTap: () {
                      viewModel.navigateToRegister(context);
                    },
                    child: Text(
                      "Don't have an account? Sign up.",
                      style: AppTypography.textStyle12Bold(
                        color: AppColor.primaryButton,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.containerMedium,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          viewModel.fillCredentials(
                            "rajsurase3@gmail.com",
                            "larick434",
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: ValuesConstants.screenWidth(context) * 0.08,
                        ),
                      ),
                      const SizedBox(
                        height: ValuesConstants.paddingTB,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.fillCredentials(
                            "r@gmail.com",
                            "larick434",
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: ValuesConstants.screenWidth(context) * 0.08,
                        ),
                      ),
                      const SizedBox(
                        height: ValuesConstants.paddingTB,
                      ),
                      GestureDetector(
                        onTap: () {
                          viewModel.fillCredentials(
                            "rajsurase70@gmail.com",
                            "larick434",
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: ValuesConstants.screenWidth(context) * 0.08,
                        ),
                      ),
                    ],
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
    Provider.of<LoginViewModel>(context, listen: false).disposeControllers();
    super.dispose();
  }
}
