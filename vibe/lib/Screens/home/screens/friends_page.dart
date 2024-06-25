import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Provider/userprovider.dart';
import 'package:vibe/Screens/home/navigation_vm.dart';
import 'package:vibe/components/user_tab.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

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

      return ViewModelBuilder<NavigatorPageViewModel>.reactive(
          viewModelBuilder: () => NavigatorPageViewModel(),
          onViewModelReady: (viewModel) {
            viewModel.initialise(context);
          },
          builder: (context, viewModel, child) {
            return const Padding(
              padding: EdgeInsets.fromLTRB(
                  ValuesConstants.paddingLR,
                  ValuesConstants.paddingTB,
                  ValuesConstants.paddingLR,
                  ValuesConstants.paddingTB),
              child: UserTab(
                title: "Raj Surase",
                subtitle: "subtitle",
                isClickable: true,
              ),
            );
          });
    });
  }
}
