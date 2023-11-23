

import 'package:my_app/Actions/basket_actions.dart';
import 'package:my_app/Models/Item.dart';
import 'package:my_app/Store/basket_state.dart';

BasketState basketReducer(BasketState state, dynamic action) {
  final BasketState newState = state;

  switch (action) {
    case BasketRemoveItemAction:
      state.items?.remove(action as ItemModel);
      newState.items = state.items;
      return newState;
    default:
      return state;
  }
}
