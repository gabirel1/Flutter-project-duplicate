import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Models/my_orders.dart';
import 'package:my_app/Models/order_item.dart';
import 'package:my_app/Pages/authentication_page.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/profile_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:my_app/Tools/utils.dart';
import 'package:redux/redux.dart';

/// The profile page
class ProfilePage extends StatefulWidget {
  /// The profile page
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

/// The profile page state
class ProfilePageState extends State<ProfilePage> {
  /// The profile page state
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  /// The platform
  final bool isWeb = MyPlatform.isWeb();

  /// (true if the user is a seller, false otherwise)
  bool isSeller = false;

  /// Not connected screen
  Widget notConnectedScreen() {
    // make a screen with 2 buttons in the middle (Log in, Register)
    // it should put Login first and then a text: "No account yet ?" and then display the second button
    // the second button should be Register
    return Center(
      child: Column(
        children: <Widget>[
          // Padding(
          //   padding:
          //       EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.1),
          // ),
          const Text(
            'You are not connected',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.sizeOf(context).height * 0.04,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                  'Log In / Register',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Item list view
  Widget itemCard(OrderItem item) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            item.item.images[0],
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        Text(
          item.item.title,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  /// Item list view
  Widget itemListView(MyOrder? orderList, BuildContext context) {
    if (orderList == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.35,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: MyColor().myWhite,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        for (final OrderItem item in orderList.items)
                          itemCard(item),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Total price ${orderList.totalPrice}\$',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        orderList.orderedAt,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
      onDidChange:
          (ProfileViewModel? previousViewModel, ProfileViewModel viewModel) {
        if (previousViewModel!.uuid != viewModel.uuid) {
          viewModel.loadUserInfo();
          isSeller = viewModel.userInfos!.isSeller;
        }
      },
      builder: (BuildContext context, ProfileViewModel viewModel) {
        return Scaffold(
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
            // add a button on the right to disconnect
            actions: <Widget>[
              if (viewModel.uuid != ' ' && viewModel.uuid != '')
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                  child: ButtonBar(
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
                            MyColor().myRed,
                          ),
                        ),
                        onPressed: () async {
                          viewModel.signOut();
                          if (context.mounted) {
                            await Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                                  return const AuthenticationPage();
                                },
                              ),
                            );
                          }
                        },
                        child: const Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: (viewModel.userInfos!.uuid == ' ' ||
                        viewModel.userInfos!.uuid == '')
                    ? <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.sizeOf(context).height * 0.20,
                          ),
                          child: notConnectedScreen(),
                        ),
                      ]
                    : <Widget>[
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: (viewModel.userInfos!
                                                        .profilePicture !=
                                                    ' ' &&
                                                viewModel.userInfos!
                                                        .profilePicture !=
                                                    '')
                                            ? Image.network(
                                                viewModel
                                                    .userInfos!.profilePicture,
                                                fit: BoxFit.cover,
                                                errorBuilder: (
                                                  BuildContext context,
                                                  Object exception,
                                                  StackTrace? stackTrace,
                                                ) {
                                                  return const CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.black,
                                                      size: 50,
                                                    ),
                                                  );
                                                },
                                              )
                                            : const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.black,
                                                  size: 50,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () {
                                        debugPrint('Edit profile picture');
                                        viewModel.changeUserPicture();
                                      },
                                      child: Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: MyColor().myGreen,
                                        ),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.black,
                                          size: 20,
                                        ),
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
                        const Text(
                          'My orders',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        for (int idx = 0; idx < viewModel.orders!.length; idx++)
                          itemListView(viewModel.orders![idx], context),
                      ],
              ),
            ),
          ),
        );
      },
    );
  }
}
