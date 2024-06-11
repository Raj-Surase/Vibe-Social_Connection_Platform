import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:vibe/Constants/colors.dart';
import 'package:vibe/Constants/typography.dart';
import 'package:vibe/Constants/values.dart';
import 'package:vibe/Provider/userprovider.dart';

class NavigatorPage extends StatefulWidget {
  final Widget child;
  const NavigatorPage({super.key, required this.child});

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
        context.replace('/navigator/home');
        break;
      case 1:
        context.replace('/navigator/friends');
        break;
      case 2:
        context.replace('/navigator/notifications');
        break;
      case 3:
        context.replace('/navigator/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Vibes',
          style: AppTypography.textStyle24Bold(color: AppColor.textHighEm),
        ),
      ),
      body: widget.child,
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
