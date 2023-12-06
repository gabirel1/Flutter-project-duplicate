import 'dart:async';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app/Elements/bottom_navigation_bar.dart';
import 'package:my_app/Pages/MainPages/profile_page.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/authentication_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:my_app/Tools/utils.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => AuthenticationPageState();
}

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

  Future<(bool, String)> _handleGoogleLoginWeb() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    debugPrint(googleProvider.toString());
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);
    if (await FirestoreService()
            .checkUserAlreadyExistsV2(userCredential.user?.uid ?? '') ==
        false) {
      // remove the user from firebase
      await userCredential.user?.delete();
      return (false, '');
    }
    debugPrint(userCredential.toString());
    return (true, userCredential.user?.uid ?? '');
  }

  Future<(bool, String)> _handleGoogleLogin() async {
    if (MyPlatform.isWeb()) {
      return _handleGoogleLoginWeb();
    }
    final GoogleSignInAccount? user = await GoogleSignIn(
      clientId:
          '495774674643-o54oh2p0eqdf4q8l0sf6rsglppl87u88.apps.googleusercontent.com',
    ).signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );

    final bool userExists =
        await FirestoreService().checkUserAlreadyExists(user?.email ?? '');
    debugPrint(userExists.toString());
    if (userExists == false) {
      return (false, '');
    }
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint(userCredential.toString());
    debugPrint(userCredential.user?.uid);
    return (true, userCredential.user?.uid ?? '');
  }

  Future<bool> _registerUserInFirebase(
    String email,
    String uuid,
    String profilePicture,
    bool isSeller,
  ) {
    return FirestoreService().addUser(
      uuid,
      email,
      profilePicture,
      isSeller: isSeller,
    );
  }

  Future<(bool, String)> _handleLogin() async {
    final bool isValid = _checkFormValidityLogin();
    if (isValid == false) return (false, 'invalid-form');

    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (await FirestoreService().checkUserAlreadyExists(email) == false) {
      debugPrint('No user found for that email.');
      return (false, 'Wrong email/password.');
    }
    try {
      final UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint('credentials $credential.toString()');
      return (true, 'Logged in successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        return (false, 'Wrong email/password.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        return (false, 'Wrong email/password.');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return (false, 'Wrong email/password.');
      }
      debugPrint(e.code);
      return (false, e.code);
    } catch (e) {
      debugPrint(e.toString());
      return (false, 'An error occured, please try again later.');
    }
  }

  Future<(bool, String)> _handleRegister() async {
    final bool isValid = _checkFormValidity();
    if (isValid == false) return (false, 'invalid-form');

    final String email = _emailController.text;
    final String password = _passwordController.text;

    try {
      final UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint(credential.toString());
      final bool res = await _registerUserInFirebase(
        email,
        credential.user!.uid,
        '',
        _wantToBeSeller,
      );
      return (res, 'Registered successfully.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        return (false, 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
        return (false, 'The account already exists for that email.');
      }
      return (false, e.code);
    } catch (e) {
      debugPrint(e.toString());
      return (false, 'An error occured, please try again later.');
    }
  }

  Future<bool> _handleGoogleRegisterWeb() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    debugPrint(googleProvider.toString());
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithPopup(googleProvider);

    if (await FirestoreService()
                .checkUserAlreadyExistsV2(userCredential.user?.uid ?? '') ==
            true ||
        userCredential.user == null ||
        userCredential.user?.email == null) {
      return false;
    }
    debugPrint(userCredential.toString());
    final bool res = await _registerUserInFirebase(
      userCredential.user!.email ?? '',
      userCredential.user!.uid,
      userCredential.user!.photoURL ?? '',
      _wantToBeSeller,
    );
    return res;
  }

  Future<bool> _handleGoogleRegister() async {
    if (MyPlatform.isWeb()) {
      return _handleGoogleRegisterWeb();
    }
    final GoogleSignInAccount? user = await GoogleSignIn(
      clientId:
          '495774674643-o54oh2p0eqdf4q8l0sf6rsglppl87u88.apps.googleusercontent.com',
    ).signIn();
    final GoogleSignInAuthentication? auth = await user?.authentication;
    debugPrint(auth?.accessToken);
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: auth?.accessToken,
      idToken: auth?.idToken,
    );
    // check if user already exists in firebas edatabase
    // if not create it
    final bool userExists =
        await FirestoreService().checkUserAlreadyExists(user?.email ?? '');
    if (userExists == true) {
      return false;
    }
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    debugPrint(userCredential.toString());
    debugPrint(userCredential.user?.uid);
    final bool res = await _registerUserInFirebase(
      userCredential.user!.email ?? '',
      userCredential.user!.uid,
      userCredential.user!.photoURL ?? '',
      _wantToBeSeller,
    );
    return res;
  }

  bool _checkFormValidityLogin() {
    final String email = _emailController.text;
    final String password = _passwordController.text;

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
                height: 10,
              ),
              ElevatedButton(
                onPressed: () async {
                  final (bool, String) res = await _handleLogin();
                  if (context.mounted) {
                    await showDialog(
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
                            res.$1 == true
                                ? 'Successfully logged in !'
                                : res.$2,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                    // redirect to profile page
                    if (res.$1 == true && context.mounted) {
                      unawaited(
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ProfilePage(),
                          ),
                        ),
                      );
                    }
                  }
                },
                child: const Text(
                  'Sign in',
                ),
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
                onPressed: () async {
                  bool worked = false;
                  String uid = '';
                  (worked, uid) = await _handleGoogleLogin();
                  debugPrint('worked: $worked, uid: "$uid"');
                  if (worked == false && context.mounted) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future<void>.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        });
                        return const AlertDialog(
                          alignment: Alignment.bottomCenter,
                          content: Text(
                            'You are not registered !\nPlease register first !',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                    return;
                  }
                  if (worked == true && context.mounted) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future<void>.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        });
                        return const AlertDialog(
                          alignment: Alignment.bottomCenter,
                          content: Text(
                            'Successfully logged in !',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                    // redirect to profile page
                    if (context.mounted) {
                      unawaited(
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                const ProfilePage(),
                          ),
                        ),
                      );
                    }
                  }
                  // store the uuid in the state
                },
                myTitle: 'Sign in with google',
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
                  final (bool, String) res = await _handleRegister();
                  if (context.mounted) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        Future<void>.delayed(const Duration(seconds: 2), () {
                          if (context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        });
                        return AlertDialog(
                          alignment: Alignment.bottomCenter,
                          // Retrieve the text that the user has entered by using the
                          // TextEditingController.
                          content: Text(
                            res.$1 == true
                                ? 'Successfully registered !\nPlease log in !'
                                : res.$2,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                  }
                },
                child: const Text(
                  'Register',
                ),
              ),
              const SizedBox(
                height: 10,
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
                onPressed: () async {
                  final bool res = await _handleGoogleRegister();
                  if (context.mounted) {
                    await showDialog(
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
                            (res == false)
                                ? 'You are already registered !\nPlease log in !'
                                : 'Successfully registered !\nPlease log in !',
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    );
                  }
                },
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
                                  child: loginSide(),
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
                                  child: registerSide(),
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
