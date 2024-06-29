import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/components/custom_textfield.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/screens/authenticate/screens/profileinit/profile_init_vm.dart';

class ProfileInit extends StatelessWidget {
  const ProfileInit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileInitViewModel>.reactive(
      viewModelBuilder: () => ProfileInitViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(),
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
                Text(
                  "Create your Profile",
                  style:
                      AppTypography.textStyle24Bold(color: AppColor.textHighEm),
                ),
                const SizedBox(height: ValuesConstants.paddingLR),
                GestureDetector(
                  onTap: () => viewModel.pickImage(context),
                  child: viewModel.selectedImageUrl == null
                      ? Container(
                          height: ValuesConstants.containerLarge,
                          width: ValuesConstants.containerLarge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                ValuesConstants.radiusCircle),
                            color: AppColor.surfaceFG,
                          ),
                          child: Center(
                              child: Text(
                            "Upload",
                            style: AppTypography.textStyle14Bold(
                                color: AppColor.textHighEm),
                          )),
                        )
                      : Container(
                          height: ValuesConstants.containerLarge,
                          width: ValuesConstants.containerLarge,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(viewModel.selectedImageUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                ),
                const SizedBox(height: ValuesConstants.containerMedium),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Username",
                      style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm),
                    ),
                    const SizedBox(height: ValuesConstants.paddingSmall),
                    CustomTextField(
                      hintText: "Username",
                      controller: viewModel.usernameController,
                      isUsername: true,
                    ),
                  ],
                ),
                const SizedBox(height: ValuesConstants.paddingLR),
                SizedBox(
                  width: ValuesConstants.screenWidth(context),
                  height: ValuesConstants.containerSmallMedium,
                  child: TextButton(
                    onPressed: () => viewModel.continueRegistration(context),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primaryButton),
                    ),
                    child: Text(
                      'Continue',
                      style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
