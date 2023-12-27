import 'dart:developer';

import 'package:my_app/Models/my_orders.dart';
import 'package:my_app/Models/order_item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The basket view model
class BasketViewModel {
  /// The basket view model
  BasketViewModel({
    required this.order,
    required this.addCart,
    required this.removeItem,
    required this.addUnit,
    required this.removeUnit,
    required this.checkout,
  });
  /// userUUID


  /// The basket view model factory
  factory BasketViewModel.factory(Store<AppState> store) {
    final String userUUID = FirestoreService().getCurrentUserUUID();

    return BasketViewModel(
      order: store.state.basket.order,
      addCart: (OrderItem item) {
        store.dispatch(BasketAddItemAction(orderItem: item));
      },
      removeItem: (OrderItem item) {
        store.dispatch(BasketRemoveItemAction(orderItem: item));
      },
      addUnit: (OrderItem item) {
        store.dispatch(BasketAddItemUnitAction(orderItem: item));
      },
      removeUnit: (OrderItem item) {
        store.dispatch(BasketRemoveItemUnitAction(orderItem: item));
      },
      checkout: (MyOrder order) async {
        if (store.state.profile.uuid != ' ' || userUUID != ' ') {
          await FirestoreService().createOrder(
              order.items, order.totalPrice, (store.state.profile.uuid == ' ')
              ? userUUID
              : store.state.profile.uuid,);
          store.dispatch(BasketCheckoutAction(order: order));
          return true;
        }
        return false;
      },
    );
  }


  /// Order
  final MyOrder order;

  /// The add cart
  final Function addCart;

  /// To remove item
  final Function removeItem;

  /// add unit
  final Function addUnit;

  /// remove unit
  final Function removeUnit;

  /// checkout
  final Future<bool> Function(MyOrder order) checkout;

}
