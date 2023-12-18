import 'package:flutter/material.dart';

/// The login page
class LoginPage extends StatefulWidget {
  /// The login page
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

/// The login page state
class LoginPageState extends State<LoginPage> {
  /// The login page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.red,
      body: Text(
        'Hello',
      ),
    );
  }
}
