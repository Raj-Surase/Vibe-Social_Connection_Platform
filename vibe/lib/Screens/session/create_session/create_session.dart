import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/components/custom_snackbar.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/screens/session/create_session/create_session_vm.dart';

class SessionCreate extends StatelessWidget {
  const SessionCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SessionCreateViewModel>.reactive(
      viewModelBuilder: () => SessionCreateViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialise(context);
        if (!viewModel.isLoggedIn(context)) {
          viewModel.redirectToAuthPage(context);
        }
      },
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                viewModel.closeDialog(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.textHighEm,
                size: ValuesConstants.iconSize,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              "Start Session",
              style: AppTypography.textStyle14Bold(color: AppColor.textHighEm),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
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
                  GestureDetector(
                    onTap: () => viewModel.pickImage(context),
                    child: viewModel.selectedImageUrl == null
                        ? Container(
                            height: ValuesConstants.containerLarge,
                            decoration: BoxDecoration(
                              color: AppColor.surfaceFG,
                              borderRadius: BorderRadius.circular(
                                ValuesConstants.radiusLarge,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "Select thumbnail",
                                style: AppTypography.textStyle14Bold(
                                  color: AppColor.textHighEm,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: ValuesConstants.containerLarge,
                            decoration: BoxDecoration(
                              color: AppColor.surfaceFG,
                              borderRadius: BorderRadius.circular(
                                ValuesConstants.radiusLarge,
                              ),
                              image: DecorationImage(
                                image:
                                    NetworkImage(viewModel.selectedImageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingTB,
                  ),
                  InkWell(
                    onTap: () => viewModel.pickImage(context),
                    child: Container(
                      height: ValuesConstants.containerSmallMedium,
                      width: ValuesConstants.screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ValuesConstants.radiusSmall,
                        ),
                        color: AppColor.primaryButton,
                      ),
                      child: Center(
                        child: Text(
                          "Upload",
                          style: AppTypography.textStyle14Bold(
                            color: AppColor.textHighEm,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingLR,
                  ),
                  Text(
                    "Session Name",
                    style: AppTypography.textStyle14Bold(
                      color: AppColor.textHighEm,
                    ),
                  ),
                  const SizedBox(
                    height: ValuesConstants.paddingSmall,
                  ),
                  CustomTextField(
                    hintText: "Session name",
                    controller: viewModel.sessionNameController,
                  ),
                  const SizedBox(height: ValuesConstants.paddingLR),
                  SizedBox(
                    width: ValuesConstants.screenWidth(context),
                    child: ElevatedButton(
                      onPressed: () {
                        viewModel.createSession(context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          AppColor.primaryButton,
                        ),
                      ),
                      child: Text(
                        'Create Session',
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
    );
  }
}
