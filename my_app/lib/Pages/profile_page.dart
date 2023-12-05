import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Elements/bottom_navigation_bar.dart';
import 'package:my_app/Pages/authentication_page.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/profile_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:my_app/Tools/utils.dart';
import 'package:redux/redux.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();
  final bool isWeb = MyPlatform.isWeb();
  bool isSeller = false;

  Widget notConnectedScreen() {
    // make a screen with 2 buttons in the middle (Log in, Register)
    // it should put Login first and then a text: "No account yet ?" and then display the second button
    // the second button should be Register
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      converter: (Store<AppState> store) =>
          ProfileViewModel.factory(store, FirestoreService()),
      onInitialBuild: (ProfileViewModel viewModel) {
        viewModel.loadUserInfo();
        isSeller = viewModel.userInfos!.isSeller;
        if (kDebugMode) {
          debugPrint('isSeller: $isSeller');
        }
      },
      builder: (BuildContext context, ProfileViewModel viewModel) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            key: drawerScaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              // remove back button
              automaticallyImplyLeading: false,
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
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.08,
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
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * 0.02,
                            left: MediaQuery.sizeOf(context).width * 0.45,
                          ),
                          child: Text(
                            viewModel.userInfos!.formatedEmail,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.sizeOf(context).width * 0.04,
                        ),
                        child: Stack(
                          children: <Widget>[
                            DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColor().myGrey,
                                  width: 4,
                                ),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    viewModel.userInfos!.profilePicture,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: MyColor().myGreen,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                  ),
                  Text(
                    (viewModel.userInfos!.uuid != ' ' &&
                            viewModel.userInfos!.uuid != '')
                        ? 'HERE'
                        : 'NOT HERE',
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            MyColor().myGreen,
                          ),
                        ),
                        onPressed: () {
                          unawaited(
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return const AuthenticationPage();
                                },
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Log in',
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            MyColor().myGreen,
                          ),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return const AuthenticationPage();
                                },
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'Disconnect',
                        ),
                      ),
                    ],
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
