// import 'dart:developer';

import 'package:my_app/Models/my_orders.dart';
import 'package:my_app/Models/order_item.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/State/basket_state.dart';

/// The basket reducer
BasketState basketReducer(BasketState state, dynamic action) {
  final BasketState newState = state;

  switch (action) {
    case final BasketRemoveItemAction action:
      state.order.items.remove(action.orderItem);
      newState.order.totalPrice -=
          action.orderItem.item.price * action.orderItem.quantity;
      newState.order.totalPrice =
          double.parse(newState.order.totalPrice.toStringAsFixed(2));
      newState.order.items = state.order.items;
      return newState;

    case final BasketAddItemAction action:
      if (state.order.items.contains(action.orderItem)) {
        state.order.items[state.order.items.indexOf(action.orderItem)]
            .quantity++;
      } else {
        state.order.items.add(action.orderItem);
      }
      newState.order = state.order;
      newState.order.totalPrice += action.orderItem.item.price;
      newState.order.totalPrice =
          double.parse(newState.order.totalPrice.toStringAsFixed(2));
      return newState;

    case final BasketAddItemUnitAction action:
      state.order.items[state.order.items.indexOf(action.orderItem)].quantity++;
      newState.order.totalPrice += action.orderItem.item.price;
      newState.order.totalPrice =
          double.parse(newState.order.totalPrice.toStringAsFixed(2));
      newState.order.items = state.order.items;
      return newState;

    case final BasketRemoveItemUnitAction action:
      if (state.order.items[state.order.items.indexOf(action.orderItem)]
              .quantity >
          1) {
        state.order.items[state.order.items.indexOf(action.orderItem)]
            .quantity--;
        newState.order.totalPrice -= action.orderItem.item.price;
      } else {
        state.order.items.removeAt(state.order.items.indexOf(action.orderItem));
        newState.order.totalPrice -= action.orderItem.item.price;
      }
      newState.order.totalPrice =
          double.parse(newState.order.totalPrice.toStringAsFixed(2));
      newState.order.items = state.order.items;
      return newState;

    case final BasketCheckoutAction action:
      state.order = MyOrder(
        userID: action.order.userID,
        items: <OrderItem>[],
        orderedAt: '',
        totalPrice: 0,
      );
      newState.order = state.order;
      return newState;
    default:
      return newState;
  }
}
