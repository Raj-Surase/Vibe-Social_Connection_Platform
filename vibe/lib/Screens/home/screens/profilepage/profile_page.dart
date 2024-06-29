import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/provider/user_provider.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Screens/home/navigation_vm.dart';
import 'package:vibe/screens/home/screens/profilepage/profile_page_vm.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (!userProvider.isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(context)
              .replace(AppRoutes.INITIALROUTE); // Navigate to auth page
        });
        return Container(
          color: AppColor.surfaceBG,
        ); // Return an empty container while redirecting
      }

      return ViewModelBuilder<ProfilePageViewModel>.reactive(
          viewModelBuilder: () => ProfilePageViewModel(),
          onViewModelReady: (viewModel) {
            viewModel.initialise(context);
          },
          builder: (context, viewModel, child) {
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
                    FutureBuilder<Map<String, dynamic>?>(
                      future: viewModel.userFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            height: ValuesConstants.containerMedium,
                            width: ValuesConstants.containerMedium,
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  ValuesConstants.paddingTB),
                              child: CircularProgressIndicator(
                                backgroundColor: AppColor.surfaceFG,
                                color: AppColor.componentActive,
                              ),
                            ),
                          );
                        } else if (snapshot.hasError || !snapshot.hasData) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: ValuesConstants.containerMedium,
                                width: ValuesConstants.containerMedium,
                                decoration: BoxDecoration(
                                  color: AppColor.surfaceFG,
                                  borderRadius: BorderRadius.circular(
                                      ValuesConstants.radiusCircle),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: ValuesConstants.paddingTB),
                                child: Text(
                                  'Error loading user data',
                                  style: AppTypography.textStyle14Bold(
                                    color: AppColor.textHighEm,
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          var userData = snapshot.data!;
                          var userName =
                              userData['user_name'] ?? 'Unknown User';
                          var imageUrl = userData['user_profile'] ?? '';

                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: ValuesConstants.containerMedium,
                                width: ValuesConstants.containerMedium,
                                decoration: BoxDecoration(
                                  color: AppColor.surfaceFG,
                                  borderRadius: BorderRadius.circular(
                                      ValuesConstants.radiusCircle),
                                  image: imageUrl.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(imageUrl))
                                      : null,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: ValuesConstants.paddingTB),
                                child: Text(
                                  userName,
                                  style: AppTypography.textStyle14Bold(
                                    color: AppColor.textHighEm,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: ValuesConstants.spaceVertical,
                    ),
                    SizedBox(
                      height: ValuesConstants.containerSmallMedium,
                      width: ValuesConstants.screenWidth(context),
                      child: TextButton(
                        onPressed: (() {}),
                        style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppColor.surfaceFG),
                        ),
                        child: Text(
                          'Edit Profile',
                          style: AppTypography.textStyle14Bold(
                              color: AppColor.textHighEm),
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
                              style: AppTypography.textStyle10Bold(
                                  color: AppColor.textHighEm),
                            ),
                            Row(
                              children: [
                                Container(
                                  height: ValuesConstants.containerSmall,
                                  width: ValuesConstants.containerSmall,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ValuesConstants.radiusCircle),
                                    color: AppColor.surfaceBG,
                                  ),
                                ),
                                const SizedBox(
                                  width: ValuesConstants.paddingSmall,
                                ),
                                Container(
                                  height: ValuesConstants.containerSmall,
                                  width: ValuesConstants.containerSmall,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ValuesConstants.radiusCircle),
                                    color: AppColor.surfaceBG,
                                  ),
                                ),
                                const SizedBox(
                                  width: ValuesConstants.paddingSmall,
                                ),
                                Container(
                                  height: ValuesConstants.containerSmall,
                                  width: ValuesConstants.containerSmall,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ValuesConstants.radiusCircle),
                                    color: AppColor.surfaceBG,
                                  ),
                                ),
                                const SizedBox(
                                  width: ValuesConstants.paddingSmall,
                                ),
                                Container(
                                  height: ValuesConstants.containerSmall,
                                  width: ValuesConstants.containerSmall,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ValuesConstants.radiusCircle),
                                    color: AppColor.surfaceBG,
                                  ),
                                ),
                                const SizedBox(
                                  width: ValuesConstants.paddingSmall,
                                ),
                                Container(
                                  height: ValuesConstants.containerSmall,
                                  width: ValuesConstants.containerSmall,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ValuesConstants.radiusCircle),
                                    color: AppColor.surfaceBG,
                                  ),
                                ),
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
                      style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm),
                    ),
                    const SizedBox(
                      height: ValuesConstants.paddingSmall,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: ValuesConstants.screenWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ValuesConstants.radiusLarge),
                          color: AppColor.surfaceFG,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                              ValuesConstants.paddingLR,
                              ValuesConstants.paddingTB,
                              ValuesConstants.paddingLR,
                              ValuesConstants.paddingTB),
                          child: Row(
                            children: [
                              Icon(
                                Icons.nightlight_round,
                                color: AppColor.textHighEm,
                                size: ValuesConstants.iconSize,
                              ),
                              const SizedBox(
                                width: ValuesConstants.paddingSmall,
                              ),
                              Text(
                                "Theme",
                                style: AppTypography.textStyle10Bold(
                                    color: AppColor.textHighEm),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: ValuesConstants.spaceVertical,
                    ),
                    Text(
                      "Quality",
                      style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm),
                    ),
                    const SizedBox(
                      height: ValuesConstants.paddingSmall,
                    ),
                    Container(
                      width: ValuesConstants.screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusLarge),
                        color: AppColor.surfaceFG,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            ValuesConstants.paddingLR,
                            ValuesConstants.paddingTB,
                            ValuesConstants.paddingLR,
                            ValuesConstants.paddingTB),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.videocam_rounded,
                                        color: AppColor.textHighEm,
                                        size: ValuesConstants.iconSize,
                                      ),
                                      const SizedBox(
                                        width: ValuesConstants.paddingSmall,
                                      ),
                                      Text(
                                        "Video Quality",
                                        style: AppTypography.textStyle10Bold(
                                            color: AppColor.textHighEm),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "High",
                                    style: AppTypography.textStyle10Bold(
                                        color: AppColor.textHighEm),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  ValuesConstants.paddingSmall),
                              child: Divider(
                                color: AppColor.componentBorder,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.volume_down_rounded,
                                      color: AppColor.textHighEm,
                                      size: ValuesConstants.iconSize,
                                    ),
                                    const SizedBox(
                                      width: ValuesConstants.paddingSmall,
                                    ),
                                    Text(
                                      "Audio Quality",
                                      style: AppTypography.textStyle10Bold(
                                          color: AppColor.textHighEm),
                                    ),
                                  ],
                                ),
                                Text(
                                  "High",
                                  style: AppTypography.textStyle10Bold(
                                      color: AppColor.textHighEm),
                                ),
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
                      "Permissions",
                      style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm),
                    ),
                    const SizedBox(
                      height: ValuesConstants.paddingSmall,
                    ),
                    Container(
                      width: ValuesConstants.screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusLarge),
                        color: AppColor.surfaceFG,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            ValuesConstants.paddingLR,
                            ValuesConstants.paddingTB,
                            ValuesConstants.paddingLR,
                            ValuesConstants.paddingTB),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.camera_alt_rounded,
                                        color: AppColor.textHighEm,
                                        size: ValuesConstants.iconSize,
                                      ),
                                      const SizedBox(
                                        width: ValuesConstants.paddingSmall,
                                      ),
                                      Text(
                                        "Camera",
                                        style: AppTypography.textStyle10Bold(
                                            color: AppColor.textHighEm),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                    child: Switch(
                                      thumbIcon: viewModel.thumbIcon,
                                      value: viewModel.light,
                                      onChanged: (bool value) {
                                        setState(() {
                                          viewModel.light = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  ValuesConstants.paddingSmall),
                              child: Divider(
                                color: AppColor.componentBorder,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.mic_none_rounded,
                                      color: AppColor.textHighEm,
                                      size: ValuesConstants.iconSize,
                                    ),
                                    const SizedBox(
                                      width: ValuesConstants.paddingSmall,
                                    ),
                                    Text(
                                      "Microphone",
                                      style: AppTypography.textStyle10Bold(
                                          color: AppColor.textHighEm),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                  child: Switch(
                                    thumbIcon: viewModel.thumbIcon,
                                    value: viewModel.light1,
                                    onChanged: (bool value) {
                                      setState(() {
                                        viewModel.light1 = value;
                                      });
                                    },
                                  ),
                                ),
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
                      "About us",
                      style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm),
                    ),
                    const SizedBox(
                      height: ValuesConstants.paddingSmall,
                    ),
                    Container(
                      width: ValuesConstants.screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusLarge),
                        color: AppColor.surfaceFG,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            ValuesConstants.paddingLR,
                            ValuesConstants.paddingTB,
                            ValuesConstants.paddingLR,
                            ValuesConstants.paddingTB),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.help_outline_rounded,
                                    color: AppColor.textHighEm,
                                    size: ValuesConstants.iconSize,
                                  ),
                                  const SizedBox(
                                    width: ValuesConstants.paddingSmall,
                                  ),
                                  Text(
                                    "Help",
                                    style: AppTypography.textStyle10Bold(
                                        color: AppColor.textHighEm),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(
                                  ValuesConstants.paddingSmall),
                              child: Divider(
                                color: AppColor.componentBorder,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  color: AppColor.textHighEm,
                                  size: ValuesConstants.iconSize,
                                ),
                                const SizedBox(
                                  width: ValuesConstants.paddingSmall,
                                ),
                                Text(
                                  "About",
                                  style: AppTypography.textStyle10Bold(
                                      color: AppColor.textHighEm),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: ValuesConstants.paddingLR,
                    ),
                    SizedBox(
                      width: ValuesConstants.screenWidth(context),
                      height: ValuesConstants.containerSmallMedium,
                      child: TextButton(
                        onPressed: () {
                          viewModel.signOut(context, userProvider);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(AppColor.surfaceFG),
                        ),
                        child: Text(
                          'Logout',
                          style: AppTypography.textStyle14Bold(
                              color: AppColor.textHighEm),
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
          });
    });
  }
}
