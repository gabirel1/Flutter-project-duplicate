import 'package:my_app/Models/item.dart';

/// The basket remove item action
class BasketRemoveItemAction {
  /// Remove an item from the basket
  BasketRemoveItemAction({required this.item});

  /// The item to remove
  Item item;
}

/// The basket add item action
class BasketAddItemAction {
  /// Add an item to the basket
  BasketAddItemAction({required this.item});

  /// The item to add
  Item item;
}
