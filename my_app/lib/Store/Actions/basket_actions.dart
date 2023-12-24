import 'package:my_app/Models/order.dart';

/// The basket remove item action
class BasketRemoveItemAction {
  /// Remove an item from the basket
  BasketRemoveItemAction({required this.item});
class BasketAddOrderAction {
  BasketAddOrderAction({required this.order});

  /// The item to remove
  Item item;
  Order order;
}

/// The basket add item action
class BasketAddItemAction {
  /// Add an item to the basket
  BasketAddItemAction({required this.item});
class BasketAddOrderUnitAction {
  BasketAddOrderUnitAction({required this.order});

  /// The item to add
  Item item;
  final Order order;
}

class BasketRemoveOrderAction {
  BasketRemoveOrderAction({required this.order});

  final Order order;
}

class BasketRemoveOrderUnitAction {
  BasketRemoveOrderUnitAction({required this.order});

  final Order order;
}