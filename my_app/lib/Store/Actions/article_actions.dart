import 'package:my_app/Models/item.dart';

/// The article remove actions
class ArticleRemoveItemAction {
  /// Remove an item from the basket
  ArticleRemoveItemAction({required this.item});

  /// The item to remove
  Item item;
}

/// The article add item actions
class ArticleAddItemAction {
  /// Add an item to the basket
  ArticleAddItemAction({required this.item});

  /// The item to add
  Item item;
}
