

import 'package:my_app/Models/Item.dart';
import 'package:my_app/Store/Actions/home_actions.dart';
import 'package:my_app/Store/State/home_state.dart';

HomeState homeReducer(HomeState state, dynamic action) {
  final HomeState newState = state;

  switch (action) {
    case HomeItemsListAction:
      state.items?.remove(action as ItemModel);
      newState.items = state.items;
      return newState;
    default:
      return state;
  }
}
