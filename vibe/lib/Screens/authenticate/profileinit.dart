import 'package:flutter/material.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';

class ProfileInit extends StatefulWidget {
  const ProfileInit({super.key});

  @override
  State<ProfileInit> createState() => _ProfileInitState();
}

class _ProfileInitState extends State<ProfileInit> {
  @override
  Widget build(BuildContext context) {
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
              style: AppTypography.textStyle24Bold(color: AppColor.textHighEm),
            ),
            const SizedBox(
              height: ValuesConstants.paddingLR,
            ),
            GestureDetector(
                onTap: () {
                  // showOptions();
                },
                // child: galleryFile == null
                //     ? Container(
                child: Container(
                  height: ValuesConstants.containerLarge,
                  width: ValuesConstants.containerLarge,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusCircle),
                    color: AppColor.surfaceFG, // Add a color for the container
                  ),
                  child: Center(
                      child: Text(
                    "Upload",
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
                  )),
                )
                // : Container(
                //     height: ValuesConstants.containerLarge,
                //     width: ValuesConstants.containerLarge,
                //     decoration: BoxDecoration(
                //       // borderRadius:
                //       //     BorderRadius.circular(ValuesConstants.radiusCircle),
                //       color:
                //           AppColor.surfaceFG, // Add a color for the container
                //       shape: BoxShape.circle,
                //       image: DecorationImage(
                //         image: FileImage(
                //           File(galleryFile!.path),
                //         ),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                ),
            const SizedBox(
              height: ValuesConstants.containerMedium,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style:
                      AppTypography.textStyle14Bold(color: AppColor.textHighEm),
                ),
                const SizedBox(
                  height: ValuesConstants.paddingSmall,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusLarge),
                    color: AppColor.surfaceFG,
                    border: Border.all(color: AppColor.componentBorder),
                  ),
                  padding: const EdgeInsets.only(
                      left: ValuesConstants.paddingTB,
                      right: ValuesConstants.paddingTB),
                  child: TextFormField(
                    // controller: _userConfirmPassController,
                    style: AppTypography.textStyle14Bold(
                        color: AppColor.textHighEm),
                    enabled: true,
                    cursorRadius:
                        const Radius.circular(ValuesConstants.radiusSmall),
                    cursorColor: AppColor.componentActive,
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: AppTypography.textStyle14Normal(
                          color: AppColor.textLowEm),
                      disabledBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      // fillColor: AppColor.surfaceFG,
                      // filled: true,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a username'; // Error message if the field is empty
                      }
                      return null; // Return null for no error
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ValuesConstants.paddingLR,
            ),
            SizedBox(
              width: ValuesConstants.screenWidth(context),
              height: ValuesConstants.containerSmallMedium,
              child: TextButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(AppColor.primaryButton),
                ),
                child: Text(
                  'Continue',
                  style:
                      AppTypography.textStyle14Bold(color: AppColor.textHighEm),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
