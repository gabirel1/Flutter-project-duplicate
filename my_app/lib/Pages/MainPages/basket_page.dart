import 'package:flutter/material.dart';

/// The basket page
class BasketPage extends StatefulWidget {
  /// The basket page
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => BasketPageState();
}

/// The basket page state
class BasketPageState extends State<BasketPage> {
  /// The basket page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'Hello',
        ),
      ),
    );
  }
}
