import 'package:my_app/Models/item.dart';

class MarketState {
  MarketState({required this.items});

  factory MarketState.initial() => MarketState(
        items: <Item>[],
      );

  List<Item> items;
}
