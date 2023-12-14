import 'package:flutter/material.dart';
import 'package:my_app/Store/Actions/home_actions.dart';
import 'package:my_app/Store/State/home_state.dart';

/// The home reducer
HomeState homeReducer(HomeState state, dynamic action) {
  final HomeState newState = state;
  switch (action.runtimeType) {
    case HomeChangePageAction _:
      debugPrint('${action.page}');
      newState.page = action.page;
      return newState;
    default:
      return newState;
  }
}
