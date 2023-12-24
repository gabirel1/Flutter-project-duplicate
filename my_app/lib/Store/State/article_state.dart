import 'package:my_app/Models/item.dart';

/// The article state
class ArticleState {
  /// The article state
  ArticleState({
    this.items,
  });

  /// The article state initial
  factory ArticleState.initial() => ArticleState(
        items: <Item>[],
      );

  /// The items
  List<Item>? items;
}
