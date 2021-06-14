import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:tawelticlient/HomePage.dart';
import 'package:tawelticlient/client/Profil.dart';

import 'constants.dart';
import 'reservation/AddReservation.dart';
import 'reservation/ReservationList.dart';
import 'reservation/ReservationList.dart';
class Accueil extends StatefulWidget {
  final int userId;
  const Accueil({Key key,this.userId}) : super(key: key);

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    List<Widget> _buildScreens() {
      return [
        HomePage(),
        ReservationtList(),
        ClientProfil(userID:widget.userId ,)
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Acceuil"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.calendar_today),
          title: ("Reservations"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.profile_circled),
          title: ("profil"),
          activeColorPrimary: KBlue,
          inactiveColorPrimary: KBeige,
        ),
      ];
    }

    return Scaffold(

      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
        true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
        true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
        NavBarStyle.style6, // Choose the nav bar style with this property.
      ),
    );
  }
}
