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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.24,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.2,
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
                        Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.sizeOf(context).width * 0.05,
                          ),
                          child: Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.15,
                              child: Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: <Widget>[
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Container(
                                      width: 120,
                                      height: 120,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x3F000000),
                                            offset: Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        // 'https://picsum.photos/seed/277/600',
                                        viewModel.userInfos!.profilePicture,
                                        errorBuilder: (
                                          BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace,
                                        ) {
                                          if (kDebugMode) {
                                            debugPrint(
                                              viewModel
                                                  .userInfos!.profilePicture,
                                            );
                                          }
                                          // fill with a gray circle
                                          // and an icon in the middle 🚫
                                          return CircleAvatar(
                                            backgroundColor: MyColor().myGrey,
                                            child: Icon(
                                              Icons.sync_problem,
                                              color: MyColor().myWhite,
                                              size: 50,
                                            ),
                                          );
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // Flexible(
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: MediaQuery.sizeOf(context).width *
                                          (isWeb ? 0.05 : 0.1),
                                    ),
                                    child: Align(
                                      child: Text(
                                        // 'USERNAME',
                                        viewModel.userInfos!.formatedEmail,
                                        style: const TextStyle(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          // overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ),
                                  if (!isWeb)
                                    Align(
                                      alignment: const AlignmentDirectional(
                                        -0.51,
                                        0.98,
                                      ),
                                      // add border color

                                      child: IconButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                            ),
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            MyColor().myGreen,
                                          ),
                                        ),
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.edit,
                                          color: MyColor().myBlack,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).height * 0.04,
                    ),
                  ),
                  const Text(
                    'HERE',
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
