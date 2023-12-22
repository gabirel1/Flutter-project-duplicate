import 'package:my_app/Store/Actions/search_actions.dart';
import 'package:my_app/Store/State/search_state.dart';

/// The search reducer
SearchState searchReducer(SearchState state, dynamic action) {
  final SearchState newState = state;
  switch (action.runtimeType) {
    case const (SearchItemsListAction):
      newState.items = action.items;
      return newState;
    default:
      return newState;
  }
}
