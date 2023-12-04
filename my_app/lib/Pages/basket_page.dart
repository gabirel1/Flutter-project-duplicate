import 'package:flutter/material.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => BasketPageState();
}

class BasketPageState extends State<BasketPage> {
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
