
import 'package:my_app/Store/Actions/home_actions.dart';
import 'package:my_app/Store/State/home_state.dart';

HomeState homeReducer(HomeState state, dynamic action) {
  final HomeState newState = state;
  switch (action.runtimeType) {
    case HomeItemsListAction:
      newState.items = action.items;
      return newState;
    default:
      return newState;
  }
}
