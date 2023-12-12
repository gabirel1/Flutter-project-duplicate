import 'package:my_app/Store/Actions/market_actions.dart';
import 'package:my_app/Store/State/market_state.dart';

MarketState marketReducer(MarketState state, dynamic action) {
  final MarketState newState = state;
  switch (action.runtimeType) {
    case MarketItemsListAction:
      newState.items = action.items;
      return newState;
    default:
      return newState;
  }
}
