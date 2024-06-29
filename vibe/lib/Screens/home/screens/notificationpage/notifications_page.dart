import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Screens/home/navigation_vm.dart';
import 'package:vibe/components/user_tab.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/provider/user_provider.dart';
import 'package:vibe/screens/home/screens/notificationpage/notifications_page_vm.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NotificationsPageViewModel>.reactive(
      viewModelBuilder: () => NotificationsPageViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialise(context);
        if (!viewModel.isLoggedIn(context)) {
          viewModel.redirectToAuthPage(context);
        }
      },
      builder: (context, viewModel, child) {
        return Container(
          color: AppColor.surfaceBG,
          child: const Padding(
            padding: EdgeInsets.fromLTRB(
                ValuesConstants.paddingLR,
                ValuesConstants.paddingTB,
                ValuesConstants.paddingLR,
                ValuesConstants.paddingTB),
            child: UserTab(
              title: "sessionName",
              subtitle: "username",
              isClickable: false,
            ),
          ),
        );
      },
    );
  }
}
