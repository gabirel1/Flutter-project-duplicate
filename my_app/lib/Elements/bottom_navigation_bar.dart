import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_app/Pages/MainPages/basket_page.dart';
import 'package:my_app/Pages/MainPages/profile_page.dart';
import 'package:my_app/Pages/home_page.dart';
import 'package:my_app/Tools/color.dart';

/// The bottom navigation bar
class MyBottomNavigationBar extends StatefulWidget
    implements PreferredSizeWidget {
  /// The bottom navigation bar
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72);
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  static int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(
      () {
        _selectedIndex = index;
        switch (index) {
          case 0:
            unawaited(
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const HomePage(),
                ),
              ),
            );
          case 1:
            unawaited(
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const BasketPage(),
                ),
              ),
            );
          case 2:
            unawaited(
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfilePage(),
                ),
              ),
            );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: MyColor().myWhite,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket_outlined),
          label: 'Basket',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_box_outlined),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: MyColor().myBlue,
      onTap: _onItemTapped,
    );
  }
}
