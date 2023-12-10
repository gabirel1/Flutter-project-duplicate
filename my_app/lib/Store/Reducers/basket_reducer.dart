import 'package:my_app/Models/order.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/State/basket_state.dart';

BasketState basketReducer(BasketState state, dynamic action) {
  final BasketState newState = state;

  switch (action.runtimeType) {
    case BasketRemoveOrderAction:
      state.orders.remove(action.order);
      newState.orders = state.orders;
      return newState;
    case BasketAddOrderAction:
      state.orders.add(action.order);
      newState.orders = state.orders;
      return newState;
    case BasketAddOrderUnitAction:
      state.orders.remove(action.order);
      action.order.quantity++;
      state.orders.add(action.order);
      newState.orders = state.orders;
      return newState;
    case BasketRemoveOrderUnitAction:
      state.orders.remove(action.order);
      action.order.quantity--;
      state.orders.add(action.order);
      newState.orders = state.orders;
      return newState;
    default:
      return newState;
  }
}
