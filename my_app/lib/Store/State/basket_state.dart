import 'package:my_app/Models/item.dart';

/// The basket state
class BasketState {
  /// The basket state
  BasketState({
    this.items,
  });

  /// The basket state initial
  factory BasketState.initial() => BasketState(
        items: <Item>[],
      );

  /// The items
  List<Item>? items;
}
