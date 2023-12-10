import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/order.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class BasketViewModel {
  BasketViewModel({
    required this.orders,
    required this.removeItemUnit,
    required this.removeItem,
    required this.addItemUnit,
  });

  factory BasketViewModel.factory(Store<AppState> store) {
    return BasketViewModel(
        orders: store.state.basket.orders,
        removeItemUnit: (Order order) {
          if (order.quantity > 1) {
            store.dispatch(BasketRemoveOrderUnitAction(order: order));
          } else {
            store.dispatch(BasketRemoveOrderAction(order: order));
          }
        },
        removeItem: (Order order) {
          store.dispatch(BasketRemoveOrderAction(order: order));
        },
        addItemUnit: (Order order) {
          store.dispatch(BasketAddOrderUnitAction(order: order));
        },
    );
  }

  final OrderSet orders;
  final Function(Order order) removeItemUnit;
  final Function(Order order) removeItem;
  final Function(Order order) addItemUnit;
}
