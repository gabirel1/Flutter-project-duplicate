import 'package:my_app/Models/item.dart';
import 'package:my_app/Store/Actions/article_actions.dart';
import 'package:my_app/Store/State/article_state.dart';

ArticleState articleReducer(ArticleState state, dynamic action) {
  final ArticleState newState = state;

  switch (action) {
    case ArticleRemoveItemAction:
      state.items?.remove(action as Item);
      newState.items = state.items;
      return newState;
    case ArticleAddItemAction:
      state.items?.add(action as Item);
      newState.items = state.items;
      return newState;
    default:
      return newState;
  }
}
