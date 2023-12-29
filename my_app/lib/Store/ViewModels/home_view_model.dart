// import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_app/Models/user_infos.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/home_actions.dart';
import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/State/home_state.dart';
import 'package:redux/redux.dart';

/// The home view model
class HomeViewModel {
  /// The home view model
  HomeViewModel({
    required this.page,
    required this.user,
    required this.loadUser,
    required this.changePage,
    required this.bottomTap,
    required this.pageController,
  });

  /// The home view model factory
  factory HomeViewModel.factory(
    Store<AppState> store,
    PageController pageController,
  ) {
    final String userUUID = FirestoreService().getCurrentUserUUID();

    return HomeViewModel(
      page: store.state.home.page,
      user: store.state.profile.userInfos,
      changePage: (int index) async {
        store.dispatch(HomeChangePageAction(page: Pages.values[index]));
      },
      bottomTap: (int index) async {
        store.dispatch(HomeChangePageAction(page: Pages.values[index]));
        await pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      },
      pageController: pageController,
      loadUser: () async {
        final UserInfos response = await FirestoreService().getUserInfos(
          (store.state.profile.uuid == ' ')
              ? userUUID
              : store.state.profile.uuid,
        );
        store.dispatch(ProfileUserInfosAction(userInfos: response));
      },
    );
  }

  /// The page
  final Pages page;

  /// User
  final UserInfos? user;

  /// Load user
  final Function loadUser;

  /// The change page
  final Function(int) changePage;

  /// The bottom tap
  final Function(int) bottomTap;

  /// The page controller
  PageController pageController;
}
