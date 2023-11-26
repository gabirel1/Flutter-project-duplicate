import 'package:my_app/Models/Item.dart';

class BasketState {

  BasketState({
    this.items,
  });

  factory BasketState.initial() => BasketState(
    items: <ItemModel>[],
  );

  List<ItemModel>? items;
}
