import 'package:my_app/Store/Actions/market_actions.dart';
import 'package:my_app/Store/State/market_state.dart';

/// The market reducer
MarketState marketReducer(MarketState state, dynamic action) {
  final MarketState newState = state;
  switch (action.runtimeType) {
    case const (MarketItemsListAction):
      newState.items = action.items;
      return newState;
    default:
      return newState;
  }
}
