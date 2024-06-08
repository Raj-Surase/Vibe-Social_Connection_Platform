import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:vibe/Pages/friendspage.dart';

import 'package:vibe/Pages/home.dart';
import 'package:vibe/Pages/notifications.dart';
import 'package:vibe/Pages/profilepage.dart';
import 'package:vibe/Screens/createsession.dart';
import 'package:vibe/Styles/colors.dart';
import 'package:vibe/Styles/typography.dart';
import 'package:vibe/Styles/values.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  late PageController _pageController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectedIndex);
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
    });
    _pageController.animateToPage(selectedIndex,
        duration: const Duration(milliseconds: 400), curve: Curves.easeOutQuad);
  }

  @override
  Widget build(BuildContext context) {
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
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _listOfWidget,
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SessionCreate(),
                ),
              );
            },
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: const Icon(
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

List<Widget> _listOfWidget = <Widget>[
  HomePage(),
  const FriendsPage(),
  const NotificationPage(),
  const ProfilePage()
];
