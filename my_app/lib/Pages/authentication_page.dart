import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/Elements/bottom_navigation_bar.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/authentication_view_model.dart';
import 'package:my_app/Tools/color.dart';
// import 'package:redux/redux.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => AuthenticationPageState();
}

class AuthenticationPageState extends State<AuthenticationPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final GlobalKey<ScaffoldState> drawerScaffoldKey =
      GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  final List<String> _tabTitles = <String>['Log In', 'Register'];
  late String _title;

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
    // if (_tabController.indexIsChanging) {
    //   setState(() {
    //     _title = _tabTitles[_tabController.index];
    //   });
    // }
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

  Future<void> _handleLogin() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;
    print(auth?.accessToken);
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential);
  }

  Future<void> _handleRegister() async {
    final GoogleSignInAccount? user = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;
    print(auth?.accessToken);
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential);
  }

  bool _checkFormValidityLogin() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

    print(password);
    // hash password

    if (email.isEmpty ||
        password.isEmpty ||
        EmailValidator.validate(email) == false) {
      return false;
    }
    return true;
  }

  bool _checkFormValidity() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final String passwordConfirm = _passwordConfirmController.text;

    print(password);
    // hash password

    if (email.isEmpty ||
        password.isEmpty ||
        passwordConfirm.isEmpty ||
        EmailValidator.validate(email) == false ||
        password != passwordConfirm) {
      return false;
    }
    return true;
  }

  Widget loginSide() {
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
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    width: 100,
                    height: 1,
                    color: Colors.black,
                  ),
                  const Text(
                    'Or Sign In with',
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
                    width: 99,
                    height: 1,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GoogleSignInButton(
                onPressed: () async => <Future<void>>{
                  _handleLogin(),
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        alignment: Alignment.bottomCenter,
                        // Retrieve the text that the user has entered by using the
                        // TextEditingController.
                        content: Text('sign in with google'),
                      );
                    },
                  ),
                },
                myTitle: 'Sign in with google',
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async => <Future<void>>{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final bool res = _checkFormValidityLogin();
                      return AlertDialog(
                        alignment: Alignment.bottomCenter,
                        // Retrieve the text that the user has entered by using the
                        // TextEditingController.
                        content: Text(
                          res == true ? 'form is valid' : 'form is not valid',
                        ),
                      );
                    },
                  ),
                },
                child: const Text(
                  'sign in',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget registerSide() {
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
              makeInput(
                label: 'Confirm Password',
                myController: _passwordConfirmController,
                obsureText: true,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                    ),
                    width: 100,
                    height: 1,
                    color: Colors.black,
                  ),
                  const Text(
                    'Or register with',
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
                    width: 99,
                    height: 1,
                    color: Colors.black,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GoogleSignInButton(
                myTitle: 'Register with Google',
                onPressed: () async => <Future<void>>{
                  _handleRegister(),
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        alignment: Alignment.bottomCenter,
                        // Retrieve the text that the user has entered by using the
                        // TextEditingController.
                        content: Text('Register with google'),
                      );
                    },
                  ),
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () async => <Future<void>>{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      final bool res = _checkFormValidity();
                      return AlertDialog(
                        alignment: Alignment.bottomCenter,
                        // Retrieve the text that the user has entered by using the
                        // TextEditingController.
                        content: Text(
                          res == true ? 'form is valid' : 'form is not valid',
                        ),
                      );
                    },
                  ),
                },
                child: const Text(
                  'sign in',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

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
      builder: (BuildContext context, AuthenticationViewModel viewModel) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
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
                        loginSide(),
                        registerSide(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const MyBottomNavigationBar(),
          ),
        );
      },
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    required this.onPressed,
    required this.myTitle,
    super.key,
  });
  final VoidCallback onPressed;
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
