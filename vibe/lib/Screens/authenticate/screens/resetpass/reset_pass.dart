import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/screens/authenticate/screens/resetpass/reset_pass_vm.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResetPasswordViewModel(),
      child: Consumer<ResetPasswordViewModel>(
        builder: (context, viewModel, child) {
          return Form(
            key: viewModel.formKey,
            child: Scaffold(
              appBar: AppBar(
                leadingWidth: ValuesConstants.containerMediumLarge,
                leading: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColor.textHighEm,
                    size: ValuesConstants.iconSize,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(ValuesConstants.paddingLR),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        "Reset Password",
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
                      controller: viewModel.emailId,
                      isSecure: false,
                    ),
                    const SizedBox(
                      height: ValuesConstants.containerSmall,
                    ),
                    SizedBox(
                      width: ValuesConstants.screenWidth(context),
                      height: ValuesConstants.containerSmallMedium,
                      child: TextButton(
                        onPressed: () => viewModel.forgotPass(context),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppColor.primaryButton),
                        ),
                        child: Text(
                          'Reset Password',
                          style: AppTypography.textStyle14Bold(
                            color: AppColor.textHighEm,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
