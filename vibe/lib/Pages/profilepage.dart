import 'package:flutter/material.dart';
import 'package:vibe/Components/custombuttonwidget.dart';
import 'package:vibe/Components/profileimage.dart';
import 'package:vibe/Screens/login.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';
import 'package:vibe/authentication/login_bl.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB,
            ValuesConstants.paddingLR,
            ValuesConstants.paddingTB),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: ValuesConstants.containerMedium,
                  width: ValuesConstants.containerMedium,
                  decoration: BoxDecoration(
                    color: AppColor.surfaceFG,
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusCircle),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: ValuesConstants.paddingTB),
                  child: Text(
                    'Session name',
                    style: AppTypography.textStyle14Bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: ValuesConstants.spaceVertical,
            ),
            SizedBox(
              height: ValuesConstants.containerSmallMedium,
              width: ValuesConstants.screenWidth(context),
              child: TextButton(
                onPressed: (() {}),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColor.surfaceFG),
                ),
                child: Text(
                  'Edit Profile',
                  style: AppTypography.textStyle14Bold,
                ),
              ),
            ),
            const SizedBox(
              height: ValuesConstants.spaceVertical,
            ),
            Container(
              height: ValuesConstants.containerMedium,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(ValuesConstants.radiusLarge),
                color: AppColor.surfaceFG,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: ValuesConstants.paddingLR,
                    right: ValuesConstants.paddingLR),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Your Friends",
                      style: AppTypography.textStyle10Bold,
                    ),
                    Row(
                      children: [
                        ProfileImage(),
                        const SizedBox(
                          width: ValuesConstants.paddingSmall,
                        ),
                        ProfileImage(),
                        const SizedBox(
                          width: ValuesConstants.paddingSmall,
                        ),
                        ProfileImage(),
                        const SizedBox(
                          width: ValuesConstants.paddingSmall,
                        ),
                        ProfileImage(),
                        const SizedBox(
                          width: ValuesConstants.paddingSmall,
                        ),
                        ProfileImage(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: ValuesConstants.spaceVertical,
            ),
            Text(
              "Appearance",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            CustomButtonWidget(
              buttons: [
                ButtonData(
                  icon: Icons.mode_night_rounded,
                  text: 'Theme',
                  onTap: () {
                    // Handle tap
                  },
                ),
              ],
            ),
            const SizedBox(
              height: ValuesConstants.spaceVertical,
            ),
            Text(
              "Quality",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            CustomButtonWidget(
              buttons: [
                ButtonData(
                  icon: Icons.videocam_rounded,
                  text: 'Video Quality',
                  trailingText: 'High',
                  onTap: () {
                    // Handle tap
                  },
                ),
                ButtonData(
                  icon: Icons.volume_down_rounded,
                  text: 'Audio Quality',
                  trailingText: 'Low',
                  onTap: () {
                    // Handle tap
                  },
                ),
              ],
            ),
            const SizedBox(
              height: ValuesConstants.spaceVertical,
            ),
            Text(
              "Permissions",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            CustomButtonWidget(
              buttons: [
                ButtonData(
                  icon: Icons.camera_alt_rounded,
                  text: 'Camera',
                  trailingSwitch: CustomSwitch(
                    initialValue: true,
                    onChanged: (value) {
                      // Handle toggle
                    },
                  ),
                  onTap: () {
                    // Handle tap
                  },
                ),
                ButtonData(
                  icon: Icons.mic_rounded,
                  text: 'Microphone',
                  trailingSwitch: CustomSwitch(
                    initialValue: true,
                    onChanged: (value) {
                      // Handle toggle
                    },
                  ),
                  onTap: () {
                    // Handle tap
                  },
                ),
              ],
            ),
            const SizedBox(
              height: ValuesConstants.spaceVertical,
            ),
            Text(
              "About us",
              style: AppTypography.textStyle14Bold,
            ),
            const SizedBox(
              height: ValuesConstants.paddingSmall,
            ),
            CustomButtonWidget(
              buttons: [
                ButtonData(
                  icon: Icons.help_rounded,
                  text: 'Help',
                  onTap: () {
                    // Handle tap
                  },
                ),
                ButtonData(
                  icon: Icons.info_rounded,
                  text: 'About',
                  onTap: () {
                    // Handle tap
                  },
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
                onPressed: (() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                }),
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColor.surfaceFG),
                ),
                child: Text(
                  'Logout',
                  style: AppTypography.textStyle14Bold,
                ),
              ),
            ),
            const SizedBox(
              height: ValuesConstants.paddingTB,
            ),
          ],
        ),
      ),
    );
  }
}
