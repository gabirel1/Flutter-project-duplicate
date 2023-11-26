import 'package:my_app/Models/item.dart';

class BasketState {

  BasketState({
    this.items,
  });

  factory BasketState.initial() => BasketState(
    items: <Item>[],
  );

  List<Item>? items;
}
