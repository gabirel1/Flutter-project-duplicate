import 'dart:async';

// import 'package:email_validator/email_validator.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
// import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/authentication_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:my_app/Tools/utils.dart';

/// The authentication page
class AuthenticationPage extends StatefulWidget {
  /// The authentication page
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => AuthenticationPageState();
}

/// The authentication page state
class AuthenticationPageState extends State<AuthenticationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final List<String> _tabTitles = <String>['Log In', 'Register'];
  late String _title;
  bool _wantToBeSeller = false;

  @override
  void initState() {
    super.initState();

    _title = _tabTitles[0];
    _tabController = TabController(
      vsync: this,
      length: 2,
    );
    _tabController.addListener(_onTabChanging);
  }

  void _onTabChanging() {
    setState(() {
      _title = _tabTitles[_tabController.index];
      _emailController.clear();
      _passwordController.clear();
      _passwordConfirmController.clear();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  /// Login screen
  Widget loginSide(
    AuthenticationViewModel viewModel,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            children: <Widget>[
              makeInput(
                label: 'Email',
                myController: _emailController,
              ),
              makeInput(
                label: 'Password',
                myController: _passwordController,
                obsureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final bool res = await viewModel.handleLogIn(
                    _emailController.text,
                    _passwordController.text,
                  );
                  if (res == true && context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Sign in',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (MyPlatform.isAndroid() == false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      width: 40,
                      height: 1,
                      color: Colors.black,
                    ),
                    const Text(
                      '  Or Sign In with  ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      width: 40,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              if (MyPlatform.isAndroid() == false)
                const SizedBox(
                  height: 20,
                ),
              if (MyPlatform.isAndroid() == false)
                GoogleSignInButton(
                  onPressed: () async {
                    final bool res = await viewModel.loginWithGoogle();
                    debugPrint('resOnpressed: $res');
                    if (res == true && context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  myTitle: 'Sign in with google',
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Register screen
  Widget registerSide(AuthenticationViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Center(
          child: Text(
            "ℹ️ Don't forget the checkbox ℹ️",
            style: TextStyle(
              fontSize: 15,
              // if text is too long it will go to the next line
              // overflow: TextOverflow.ellipsis,
              color: Colors.black,
            ),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'I want to be a Seller',
                style: TextStyle(
                  fontSize: 15,
                  // if text is too long it will go to the next line
                  // overflow: TextOverflow.ellipsis,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Checkbox(
                value: _wantToBeSeller,
                onChanged: (bool? value) {
                  debugPrint(value.toString());
                  setState(() {
                    _wantToBeSeller = value ?? false;
                  });
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
          ),
          child: Column(
            children: <Widget>[
              makeInput(
                label: 'Email',
                myController: _emailController,
              ),
              makeInput(
                label: 'Password',
                myController: _passwordController,
                obsureText: true,
              ),
              makeInput(
                label: 'Confirm Password',
                myController: _passwordConfirmController,
                obsureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  await viewModel.handleRegister(
                    _emailController.text,
                    _passwordController.text,
                    _passwordConfirmController.text,
                    _wantToBeSeller,
                  );
                },
                child: const Text(
                  'Register',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              if (MyPlatform.isAndroid() == false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      width: 40,
                      height: 1,
                      color: Colors.black,
                    ),
                    const Text(
                      '  Or register with  ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      // make the width of the line take the remaining space
                      width: 40,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
              if (MyPlatform.isAndroid() == false)
                const SizedBox(
                  height: 20,
                ),
              if (MyPlatform.isAndroid() == false)
                GoogleSignInButton(
                  myTitle: 'Register with Google',
                  onPressed: () async {
                    await viewModel.registerWithGoogle();
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Widget input
  Widget makeInput({
    dynamic label,
    dynamic myController,
    dynamic obsureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obsureText,
          controller: myController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthenticationViewModel>(
      converter: AuthenticationViewModel.factory,
      onInitialBuild: (AuthenticationViewModel viewModel) {},
      onDidChange: (
        AuthenticationViewModel? previousViewModel,
        AuthenticationViewModel viewModel,
      ) {
        if (viewModel.error != null &&
            viewModel.error != previousViewModel?.error) {
          unawaited(
            showDialog(
              context: context,
              builder: (BuildContext context) {
                Future<void>.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                });
                return AlertDialog(
                  alignment: Alignment.bottomCenter,
                  content: Text(
                    viewModel.error?.message ?? 'An error occured.',
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          );
        }
        if (viewModel.dialogNotif != null &&
            viewModel.dialogNotif != previousViewModel?.dialogNotif &&
            viewModel.dialogNotif?.message.isNotEmpty == true) {
          unawaited(
            showDialog(
              context: context,
              builder: (BuildContext context) {
                Future<void>.delayed(const Duration(seconds: 2), () {
                  if (context.mounted) {
                    Navigator.of(context).pop(true);
                  }
                });
                return AlertDialog(
                  alignment: Alignment.bottomCenter,
                  content: Text(
                    viewModel.dialogNotif!.message,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          );
        }
      },
      builder: (BuildContext context, AuthenticationViewModel viewModel) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(_title),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    MyColor().myGreen,
                    MyColor().myBlue,
                  ],
                  stops: const <double>[0, 1],
                  begin: AlignmentDirectional.centerEnd,
                  end: AlignmentDirectional.bottomStart,
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Scaffold(
            body: Column(
              children: <Widget>[
                Align(
                  child: TabBar(
                    labelColor: MyColor().myGreen,
                    unselectedLabelColor: MyColor().myBlack,
                    labelStyle: const TextStyle(
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w500,
                    ),
                    unselectedLabelStyle: const TextStyle(),
                    indicatorColor: MyColor().myGreen,
                    indicatorWeight: 4,
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: const <Widget>[
                      Tab(
                        text: 'Log In',
                      ),
                      Tab(
                        text: 'Register',
                      ),
                    ],
                    controller: _tabController,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Builder(
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            slivers: <Widget>[
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: loginSide(viewModel),
                              ),
                            ],
                          );
                        },
                      ),
                      Builder(
                        builder: (BuildContext context) {
                          return CustomScrollView(
                            slivers: <Widget>[
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: registerSide(viewModel),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Widget GoogleSignInButton
class GoogleSignInButton extends StatelessWidget {
  /// Widget GoogleSignInButton
  const GoogleSignInButton({
    required this.onPressed,
    required this.myTitle,
    super.key,
  });

  /// The onPressed function
  final VoidCallback onPressed;

  /// The title of the button
  final String myTitle;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Image.asset(
              'assets/images/google_logo.png',
              width: 24,
              height: 24,
              errorBuilder: (
                BuildContext context,
                Object exception,
                StackTrace? stackTrace,
              ) {
                return const Text('😢');
              },
            ),
          ),
          const SizedBox(width: 4),
          Text(
            // 'Sign in with Google',
            myTitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[850],
            ),
          ),
        ],
      ),
    );
  }
}
