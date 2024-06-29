import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/components/user_tab.dart';
import 'package:vibe/screens/home/screens/friendspage/friends_page_vm.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FriendsPageViewModel>.reactive(
        viewModelBuilder: () => FriendsPageViewModel(),
        onViewModelReady: (viewModel) {
          viewModel.initialise(context);
          if (!viewModel.isLoggedIn(context)) {
            viewModel.redirectToAuthPage(context);
          }
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
  }
}
