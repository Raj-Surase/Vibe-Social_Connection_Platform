import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/routes.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Screens/home/navigation_vm.dart';
import 'package:vibe/components/dialog_exit.dart';
import 'package:vibe/provider/user_provider.dart';
import 'package:vibe/screens/home/screens/friendspage/friends_page.dart';
import 'package:vibe/screens/home/screens/homepage/home_page.dart';
import 'package:vibe/screens/home/screens/notificationpage/notifications_page.dart';
import 'package:vibe/screens/home/screens/profilepage/profile_page.dart';

class NavigatorPage extends StatefulWidget {
  final int initialIndex;
  const NavigatorPage({super.key, required this.initialIndex});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
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
          viewModel.currentIndexHome(widget.initialIndex);
        },
        builder: (context, viewModel, child) {
          final tabs = [
            const HomePage(),
            const FriendsPage(),
            const NotificationPage(),
            const ProfilePage(),
          ];
          return BackButtonListener(
            onBackButtonPressed: () {
              if (viewModel.currentIndex != 1) {
                viewModel.tabChange(1);
              } else {
                return Future.value(handleBackButtonPress(context));
              }
              return Future.value(true);
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Vibes',
                  style:
                      AppTypography.textStyle24Bold(color: AppColor.textHighEm),
                ),
              ),
              body: tabs[viewModel.currentIndex],
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Visibility(
                visible: viewModel.currentIndex == 0,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(ValuesConstants.radiusCircle),
                    color: AppColor.surfaceFG,
                    border: Border.all(
                      color: AppColor.surfaceBG,
                      width: 5,
                    ),
                  ),
                  child: FloatingActionButton(
                    onPressed: () {
                      context.push('/create_session');
                    },
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    child: Icon(
                      Icons.add_rounded,
                      color: AppColor.componentActive,
                      size: ValuesConstants.iconSize,
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: SlidingClippedNavBar(
                backgroundColor: AppColor.surfaceFG,
                onButtonPressed: (int index) {
                  viewModel.tabChange(index);
                },
                iconSize: ValuesConstants.iconSize,
                activeColor: AppColor.componentActive,
                inactiveColor: AppColor.componentInactive,
                selectedIndex: viewModel.currentIndex,
                fontSize: 14,
                barItems: <BarItem>[
                  BarItem(
                    icon: Icons.home_rounded,
                    title: 'Home',
                  ),
                  BarItem(
                    icon: Icons.people_rounded,
                    title: 'Friends',
                  ),
                  BarItem(
                    icon: Icons.notifications_rounded,
                    title: 'Notifications',
                  ),
                  BarItem(
                    icon: Icons.person_rounded,
                    title: 'Profile',
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
