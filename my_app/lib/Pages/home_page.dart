import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:my_app/Elements/app_bar.dart';
import 'package:my_app/Elements/bottom_navigation_bar.dart';
import 'package:my_app/Repository/FirestoreService.dart';
import 'package:my_app/Store/ViewModels/home_view_model.dart';
import 'package:my_app/Tools/color.dart';
import 'package:redux/redux.dart';

import '../Store/State/app_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, HomeViewModel>(
        converter: (Store<AppState> store) =>
            HomeViewModel.factory(store, FirestoreService()),
        onInitialBuild: (HomeViewModel viewModel) {
          viewModel.loadItems();
        },
        builder: (BuildContext context, HomeViewModel viewModel) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              appBar: const MyAppBar(),
              backgroundColor: MyColor().myWhite,
              body: Scaffold(
                key: drawerScaffoldKey,
                body: viewModel.items.isEmpty ? Text("ça charge....") :
                ListView.builder(
                  itemCount: viewModel.items.length,
                  itemBuilder: (BuildContext context, int index) {
                  return Text(viewModel.items.elementAt(index).title);
                },
              ),
              bottomNavigationBar: const MyBottomNavigationBar(),
            ),
          ),);
        },
    );
  }
}
