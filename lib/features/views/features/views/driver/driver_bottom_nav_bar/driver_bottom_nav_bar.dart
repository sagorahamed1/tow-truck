import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:towservice/features/views/features/views/driver/driver_home/driver_home_screen.dart';
import 'package:towservice/global/custom_assets/assets.gen.dart';
import 'package:towservice/utils/app_colors.dart';

import '../../message/message_user_screen.dart';

class CustomNavBarScreen extends StatelessWidget {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [

      DriverHomeScreen(),
      DriverHomeScreen(),
      DriverHomeScreen(),
      MessageUserScreen(),
      DriverHomeScreen()

    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Assets.icons.homeNavIcon.svg(),
        inactiveIcon: Assets.icons.homeNavIcon.svg(color: Colors.black),
        title: ("Home"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),

      PersistentBottomNavBarItem(
        icon: Assets.icons.tripIcon.svg(color: AppColors.primaryColor),
        inactiveIcon: Assets.icons.tripIcon.svg(color: Colors.black),
        title: ("Trip"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),

      // PersistentBottomNavBarItem(
      //   icon: Assets.icons.welletNavIcon.svg(),
      //   title: ("Wallet"),
      //   activeColorPrimary: AppColors.primaryColor,
      //   inactiveColorPrimary: Colors.grey,
      // ),

      PersistentBottomNavBarItem(
        icon: buildHexagonIcon(
          Assets.icons.welletNavIcon.svg(width: 26, height: 26),
          isActive: true,
        ),
        inactiveIcon: buildHexagonIcon(
          Assets.icons.welletNavIcon.svg(width: 26, height: 26),
          isActive: true,
        ),
        title: ("Wallet"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),




      PersistentBottomNavBarItem(
        icon: Assets.icons.chatIcon.svg(color: AppColors.primaryColor),
        inactiveIcon: Assets.icons.chatIcon.svg(color: Colors.black),
        title: ("Chat"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),



      PersistentBottomNavBarItem(
        icon: Assets.icons.profileNavIcon.svg(color: AppColors.primaryColor),
        inactiveIcon: Assets.icons.profileNavIcon.svg(color: Colors.black),
        title: ("Profile"),
        activeColorPrimary: AppColors.primaryColor,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      navBarHeight: 70,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      // hideNavigationBarWhenKeyboardShows: true,

      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.grey.shade100,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      navBarStyle: NavBarStyle.style15,
    );
  }



  Widget buildHexagonIcon(Widget icon, {bool isActive = false}) {
    return ClipPolygon(
      sides: 6,
      borderRadius: 5.0,
      rotate: 90.0,
      child: Container(
        width: 60,
        height: 60,
        color: isActive ? AppColors.primaryColor : Colors.grey.shade300,
        child: Center(child: icon),
      ),
    );
  }

}