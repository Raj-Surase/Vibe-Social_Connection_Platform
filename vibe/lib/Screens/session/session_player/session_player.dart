import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/provider/user_provider.dart';

class SessionPlayer extends StatefulWidget {
  const SessionPlayer({this.title = "User", super.key});

  final String title;

  @override
  State<SessionPlayer> createState() => _SessionPlayerState();
}

class _SessionPlayerState extends State<SessionPlayer> {
  final TextEditingController _messageController = TextEditingController();

  final List messages = List.filled(50, "Hello...");

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        if (!userProvider.isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            GoRouter.of(context)
                .replace(AppRoutes.INITIALROUTE); // Navigate to login page
          });
          return Container(
            color: AppColor.surfaceBG,
          ); // Return an empty container while redirecting
        }
        return Scaffold(
          // appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              ValuesConstants.paddingLR,
              ValuesConstants.containerMedium,
              ValuesConstants.paddingLR,
              ValuesConstants.paddingTB,
            ),
            child: Column(
              children: [
                Container(
                  height: ValuesConstants.containerLarge,
                  width: ValuesConstants.screenWidth(context),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusMedium),
                    color: AppColor.surfaceFG,
                  ),
                ),
                SizedBox(
                  height: ValuesConstants.paddingTB,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusMedium),
                    color: AppColor.surfaceFG,
                  ),
                  padding: EdgeInsets.all(ValuesConstants.paddingSmall),
                  child: Row(
                    children: [
                      Container(
                        height: ValuesConstants.containerSmallMedium,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ValuesConstants.radiusSmall),
                          color: AppColor.componentInactive,
                        ),
                      ),
                      SizedBox(
                        width: ValuesConstants.paddingSmall,
                      ),
                      Container(
                        height: ValuesConstants.containerSmallMedium,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ValuesConstants.radiusSmall),
                          color: AppColor.componentBorder,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    reverse: true, // Display messages from bottom to top
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: ValuesConstants.paddingTB),
                            child: Container(
                              height: ValuesConstants.containerSmall,
                              width: ValuesConstants.containerSmall,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ValuesConstants.radiusCircle),
                                color: AppColor.surfaceFG,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: ValuesConstants.paddingSmall,
                          ),
                          Text(
                            messages[index].toString(),
                            style: AppTypography.textStyle10Bold(
                                color: AppColor.textHighEm),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ValuesConstants.radiusLarge),
                          color: AppColor.surfaceFG,
                        ),
                        padding: const EdgeInsets.only(
                            left: ValuesConstants.paddingTB,
                            right: ValuesConstants.paddingTB),
                        child: TextField(
                          controller: _messageController,
                          style: AppTypography.textStyle14Bold(
                              color: AppColor.textHighEm),
                          cursorRadius: const Radius.circular(
                              ValuesConstants.radiusSmall),
                          cursorColor: AppColor.componentActive,
                          decoration: InputDecoration(
                            hintText: 'Enter your message...',
                            hintStyle: AppTypography.textStyle14Normal(
                                color: AppColor.textLowEm),
                            border: InputBorder.none,

                            // fillColor: AppColor.surfaceFG,
                            // filled: true,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: ValuesConstants.paddingSmall),
                    IconButton(
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.send_rounded,
                        color: AppColor.componentActive,
                        size: ValuesConstants.paddingLR,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
