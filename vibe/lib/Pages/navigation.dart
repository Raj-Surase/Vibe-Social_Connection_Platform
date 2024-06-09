import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Pages/friendspage.dart';
import 'package:vibe/Pages/home.dart';
import 'package:vibe/Pages/notifications.dart';
import 'package:vibe/Pages/profilepage.dart';
import 'package:vibe/Provider/userprovider.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  int selectedIndex = 0;

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (selectedIndex) {
      case 0:
        context.go('/navigator/home');
        break;
      case 1:
        context.go('/navigator/friends');
        break;
      case 2:
        context.go('/navigator/notifications');
        break;
      case 3:
        context.go('/navigator/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vibes',
          style: AppTypography.textStyle24Bold,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Navigator(
              onGenerateRoute: (settings) {
                Widget page;
                switch (settings.name) {
                  case '/navigator/home':
                    page = HomePage();
                    break;
                  case '/navigator/friends':
                    page = FriendsPage();
                    break;
                  case '/navigator/notifications':
                    page = NotificationPage();
                    break;
                  case '/navigator/profile':
                    page = ProfilePage();
                    break;
                  default:
                    page = HomePage();
                }
                return MaterialPageRoute(builder: (_) => page);
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: selectedIndex == 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ValuesConstants.radiusCircle),
            color: AppColor.surfaceFG,
            border: Border.all(
              color: AppColor.surfaceBG,
              width: 5,
            ),
          ),
          child: FloatingActionButton(
            onPressed: () {
              context.go('/navigator/create_session');
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
        onButtonPressed: onButtonPressed,
        iconSize: ValuesConstants.iconSize,
        activeColor: AppColor.componentActive,
        inactiveColor: AppColor.componentInactive,
        selectedIndex: selectedIndex,
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
    );
  }
}
