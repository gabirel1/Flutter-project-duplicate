import 'package:flutter/material.dart';
import 'package:my_app/Elements/app_bar.dart';
import 'package:my_app/Elements/bottom_navigation_bar.dart';
import 'package:my_app/Tools/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: const MyAppBar(),
        backgroundColor: MyColor().myWhite,
        body: Scaffold(
          key: drawerScaffoldKey,
        ),
        bottomNavigationBar: const MyBottomNavigationBar(),
      ),
    );
  }
}
