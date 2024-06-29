import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/provider/user_provider.dart';
import 'package:vibe/screens/session/session_vm.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SessionViewModel>.reactive(
      viewModelBuilder: () => SessionViewModel(),
      onViewModelReady: (viewModel) {
        if (!viewModel.isLoggedIn(context)) {
          viewModel.redirectToLoginPage(context);
        }
      },
      builder: (context, viewModel, child) {
        if (!viewModel.isLoggedIn(context)) {
          return Container(color: AppColor.surfaceBG);
        }

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              ValuesConstants.paddingLR,
              ValuesConstants.containerMedium,
              ValuesConstants.paddingLR,
              ValuesConstants.paddingTB,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: ValuesConstants.containerLarge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ValuesConstants.radiusLarge,
                        ),
                        color: AppColor.surfaceFG,
                      ),
                    ),
                    const SizedBox(
                      height: ValuesConstants.paddingTB,
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
                    Text(
                      "Views | Started on",
                      style: AppTypography.textStyle8Normal(
                        color: AppColor.textHighEm,
                      ),
                    ),
                    const SizedBox(
                      height: ValuesConstants.paddingTB,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: ValuesConstants.containerSmall,
                              width: ValuesConstants.containerSmall,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  ValuesConstants.radiusCircle,
                                ),
                                color: AppColor.surfaceFG,
                              ),
                            ),
                            const SizedBox(
                              width: ValuesConstants.paddingSmall,
                            ),
                            Text(
                              "Username",
                              style: AppTypography.textStyle10Bold(
                                color: AppColor.textHighEm,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(
                                ValuesConstants.containerMediumLarge,
                                ValuesConstants.containerSmall,
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              AppColor.surfaceFG,
                            ),
                          ),
                          child: Text(
                            "Add Friend",
                            style: AppTypography.textStyle10Bold(
                              color: AppColor.textHighEm,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ListView.builder(
                      reverse: true,
                      itemCount: viewModel.messages.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: ValuesConstants.paddingTB,
                              ),
                              child: Container(
                                height: ValuesConstants.containerSmall,
                                width: ValuesConstants.containerSmall,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    ValuesConstants.radiusCircle,
                                  ),
                                  color: AppColor.surfaceFG,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: ValuesConstants.paddingSmall,
                            ),
                            Text(
                              viewModel.messages[index].toString(),
                              style: AppTypography.textStyle10Bold(
                                color: AppColor.textHighEm,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            ValuesConstants.radiusLarge,
                          ),
                          color: AppColor.surfaceFG,
                        ),
                        padding: const EdgeInsets.only(
                          left: ValuesConstants.paddingTB,
                          right: ValuesConstants.paddingTB,
                        ),
                        child: TextField(
                          controller: viewModel.messageController,
                          style: AppTypography.textStyle14Bold(
                            color: AppColor.textHighEm,
                          ),
                          cursorRadius: const Radius.circular(
                            ValuesConstants.radiusSmall,
                          ),
                          cursorColor: AppColor.componentActive,
                          decoration: InputDecoration(
                            hintText: 'Enter your message...',
                            hintStyle: AppTypography.textStyle14Normal(
                              color: AppColor.textHighEm,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: ValuesConstants.paddingSmall),
                    IconButton(
                      onPressed: viewModel.sendMessage,
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
