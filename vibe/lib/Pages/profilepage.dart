import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Provider/userprovider.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool light = false;
  late bool light1 = false;

  final FirebaseAuth auth = FirebaseAuth.instance;

  String imageUrl = "";
  bool isLoading = true;

  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(
          Icons.check,
          size: ValuesConstants.iconSize,
        );
      }
      return const Icon(
        Icons.close,
        size: ValuesConstants.iconSize,
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, _) {
      if (!userProvider.isLoggedIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(context).replace('/auth'); // Navigate to auth page
        });
        return Container(
          color: AppColor.surfaceBG,
        ); // Return an empty container while redirecting
      }

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
                  if (isLoading)
                    SizedBox(
                      height: ValuesConstants.containerMedium,
                      width: ValuesConstants.containerMedium,
                      child: Padding(
                        padding:
                            const EdgeInsets.all(ValuesConstants.paddingTB),
                        child: CircularProgressIndicator(
                          backgroundColor: AppColor.surfaceFG,
                          color: AppColor.componentActive,
                        ),
                      ),
                    )
                  else
                    Container(
                      height: ValuesConstants.containerMedium,
                      width: ValuesConstants.containerMedium,
                      decoration: BoxDecoration(
                        color: AppColor.surfaceFG,
                        borderRadius:
                            BorderRadius.circular(ValuesConstants.radiusCircle),
                        image: DecorationImage(image: NetworkImage(imageUrl)),
                      ),
                    ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: ValuesConstants.paddingTB),
                    child: Text(
                      'Session name',
                      style: AppTypography.textStyle14Bold(
                          color: AppColor.textHighEm),
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
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColor.surfaceFG),
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
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
              ),
              const SizedBox(
                height: ValuesConstants.paddingSmall,
              ),
              InkWell(
                onTap: () {},
                child: Container(
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
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        padding:
                            const EdgeInsets.all(ValuesConstants.paddingSmall),
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
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                thumbIcon: thumbIcon,
                                value: light,
                                onChanged: (bool value) {
                                  setState(() {
                                    light = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.all(ValuesConstants.paddingSmall),
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
                              thumbIcon: thumbIcon,
                              value: light1,
                              onChanged: (bool value) {
                                setState(() {
                                  light1 = value;
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
                style:
                    AppTypography.textStyle14Bold(color: AppColor.textHighEm),
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
                        padding:
                            const EdgeInsets.all(ValuesConstants.paddingSmall),
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
                    FirebaseAuth.instance.signOut();
                    userProvider.signOut();
                    context.go('/');
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(AppColor.surfaceFG),
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
  }
}
