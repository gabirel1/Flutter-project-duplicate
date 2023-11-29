import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Elements/bottom_navigation_bar.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/ViewModels/profile_view_model.dart';
import 'package:redux/redux.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ProfileViewModel>(
      converter: (Store<AppState> store) =>
          ProfileViewModel.factory(store, FirestoreService()),
      onInitialBuild: (ProfileViewModel viewModel) {
        viewModel.loadUserInfo();
      },
      builder: (BuildContext context, ProfileViewModel viewModel) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: Colors.yellow,
            body: Center(
              child: Text(
                viewModel.userInfos!.email,
              ),
            ),
            bottomNavigationBar: const MyBottomNavigationBar(),
          ),
        );
      },
    );
    // return WillPopScope(
    //   onWillPop: () async {
    //     return false;
    //   },
    //   child: const Scaffold(
    //     body: Scaffold(
    //       backgroundColor: Colors.yellow,
    //       body: Center(
    //         child: Text(
    //           'Hello',
    //         ),
    //       ),
    //     ),
    //     bottomNavigationBar: MyBottomNavigationBar(),
    //   ),
    // );
  }
}
