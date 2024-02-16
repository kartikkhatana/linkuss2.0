import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkuss/pages/homeScreen.dart';
import 'package:linkuss/pages/trackPage.dart';
import 'package:linkuss/pages/userProfilePage.dart';
import 'package:linkuss/utils/colors.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  var pageList = [];
  int _selectedIndex = 0;
  bool showsearchrecommend = false;

  @override
  void initState() {
    super.initState();
    pageList = [HomeScreen(), TrackingPage(), UserProfilePage()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: pageList.elementAt(_selectedIndex),
      ),
      // bottomNavigationBar: Container(
      //   decoration: const BoxDecoration(
      //     borderRadius: BorderRadius.only(
      //         topRight: Radius.circular(40), topLeft: Radius.circular(40)),
      //     boxShadow: [
      //       BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
      //     ],
      //   ),
      //   child: ClipRRect(
      //     borderRadius: const BorderRadius.only(
      //       topLeft: Radius.circular(40.0),
      //       topRight: Radius.circular(40.0),
      //     ),
      //     child:
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: MyColors.primary,
        // backgroundColor: Colors.blue,
        items: [
          BottomNavyBarItem(
            title: Text(
              "Home",
              style: TextStyle(color: Colors.white),
            ),
            icon: SizedBox(
                  child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            // activeIcon: Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.0),
            //   child: Icon(
            //     Icons.home,
            //     color: MyColors.primary,
            //   ),
            // ),
            // label: ""
          ),
          BottomNavyBarItem(
            title: Text(
              "Track",
              style: TextStyle(color: Colors.white),
            ),
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                  child: Icon(
                Icons.timeline,
                color: Colors.white,
              )),
            ),
            // activeIcon: Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.0),
            //   child: Icon(
            //     Icons.explore,
            //     color: MyColors.primary,
            //   ),
            // ),
            // label: ""
          ),
          BottomNavyBarItem(
            title: Text(
              "Profile",
              style: TextStyle(color: Colors.white),
            ),
            icon: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                  child: Icon(
                Icons.person,
                color: Colors.white,
              )),
            ),
            // activeIcon: Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10.0),
            //   child: Icon(
            //     Icons.person,
            //     color: MyColors.primary,
            //   ),
            // ),
            //label: ""
          ),
        ],
        selectedIndex: _selectedIndex,
        //currentIndex: _selectedIndex,
        //  onTap: (int index) {},
        onItemSelected: (int index) {
          _onItemTapped(index);
        },
      ),
      //  ),
      // ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      //control forward and back arrows functioning from here

      _selectedIndex = index;
    });
  }
}
