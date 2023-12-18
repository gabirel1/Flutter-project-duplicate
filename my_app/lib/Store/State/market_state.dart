import 'package:my_app/Models/item.dart';

/// The market state
class MarketState {
  /// The market state
  MarketState({
    required this.items,
  });

  /// The market state initial
  factory MarketState.initial() => MarketState(
        items: <Item>[],
      );

  /// The items
  List<Item> items;
}
