import 'package:my_app/Models/item.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/State/basket_state.dart';

/// The basket reducer
BasketState basketReducer(BasketState state, dynamic action) {
  final BasketState newState = state;

  switch (action) {
    case BasketRemoveItemAction _:
      state.items?.remove(action as Item);
      newState.items = state.items;
      return newState;
    case BasketAddItemAction _:
      state.items?.add(action as Item);
      newState.items = state.items;
      return newState;
    default:
      return newState;
  }
}
