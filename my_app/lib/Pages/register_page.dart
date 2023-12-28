import 'package:flutter/material.dart';

/// The register page
class RegisterPage extends StatefulWidget {
  /// The register page
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

/// The register page state
class RegisterPageState extends State<RegisterPage> {
  /// The register page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Scaffold(
          key: drawerScaffoldKey,
        ),
    );
  }
}
