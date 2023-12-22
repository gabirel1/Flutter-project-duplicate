import 'package:my_app/Models/item.dart';

/// The search state
class SearchState {
  /// The search state
  SearchState({
    required this.items,
  });

  /// The search state initial
  factory SearchState.initial() => SearchState(
        items: <Item>[],
      );

  /// The items
  List<Item> items;
}
