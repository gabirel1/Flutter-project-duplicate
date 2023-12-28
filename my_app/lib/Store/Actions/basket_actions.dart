import 'package:my_app/Models/my_orders.dart';
import 'package:my_app/Models/order_item.dart';

/// The basket remove item action
class BasketRemoveItemAction {
  /// Remove an item from the basket
  BasketRemoveItemAction({required this.orderItem});

  /// The item to remove
  OrderItem orderItem;
}

/// The basket add item action
class BasketAddItemAction {
  /// Add an item to the basket
  BasketAddItemAction({required this.orderItem});

  /// The item to add
  OrderItem orderItem;
}

/// BasketAddItemUnitAction
class BasketAddItemUnitAction {

  /// Constructor
  BasketAddItemUnitAction({required this.orderItem});

  /// item
  OrderItem orderItem;

}

/// BasketRemoveItemUnitAction
class BasketRemoveItemUnitAction {

  /// Constructor
  BasketRemoveItemUnitAction({required this.orderItem});

  /// item
  OrderItem orderItem;

}

/// BasketCheckoutAction
class BasketCheckoutAction {

  /// Constructor
  BasketCheckoutAction({required this.order});

  /// order
  MyOrder order;
}
