import 'dart:developer';

import 'package:my_app/Store/Actions/market_actions.dart';
import 'package:my_app/Store/State/market_state.dart';

/// The market reducer
MarketState marketReducer(MarketState state, dynamic action) {
  final MarketState newState = state;
  switch (action) {
    case final MarketItemsListAction action:
      log('ZBLUBLA');
      newState.items = action.items;
      return newState;
    default:
      return newState;
  }
}
