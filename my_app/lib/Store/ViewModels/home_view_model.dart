// import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_app/Store/Actions/home_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:my_app/Store/State/home_state.dart';
import 'package:redux/redux.dart';

/// The home view model
class HomeViewModel {
  /// The home view model
  HomeViewModel({
    required this.page,
    required this.changePage,
    required this.bottomTap,
    required this.pageController,
  });

  /// The home view model factory
  factory HomeViewModel.factory(
    Store<AppState> store,
    PageController pageController,
  ) {
    return HomeViewModel(
      page: store.state.home.page,
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
    );
  }

  /// The page
  final Pages page;

  /// The change page
  final Function(int) changePage;

  /// The bottom tap
  final Function(int) bottomTap;

  /// The page controller
  PageController pageController;
}
