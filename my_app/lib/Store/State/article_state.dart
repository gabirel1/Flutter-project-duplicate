import 'package:my_app/Models/item.dart';

class ArticleState {
  ArticleState({
    this.items,
  });

  factory ArticleState.initial() => ArticleState(
        items: <Item>[],
      );

  List<Item>? items;
}
