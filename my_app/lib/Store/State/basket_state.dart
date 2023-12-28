import 'package:my_app/Models/my_orders.dart';
import 'package:my_app/Models/order_item.dart';

/// The basket state
class BasketState {
  /// The basket state
  BasketState({
    required this.order,
  });

  /// The basket state initial
  factory BasketState.initial() => BasketState(
        order: MyOrder(userID: '', items: <OrderItem>[], orderedAt: '', totalPrice: 0),
      );

  /// Order
  MyOrder order;
}
