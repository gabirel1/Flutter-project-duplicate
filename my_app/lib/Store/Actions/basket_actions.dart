import 'package:my_app/Models/item.dart';

class BasketRemoveItemAction {
  BasketRemoveItemAction({required this.item});

  Item item;
}

class BasketAddItemAction {
  BasketAddItemAction({required this.item});

  Item item;
}
