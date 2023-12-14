import 'package:my_app/Models/item.dart';
import 'package:my_app/Store/Actions/article_actions.dart';
import 'package:my_app/Store/State/article_state.dart';

/// The article reducer
ArticleState articleReducer(ArticleState state, dynamic action) {
  final ArticleState newState = state;

  switch (action) {
    /// The article remove actions
    case const (ArticleRemoveItemAction):
      state.items?.remove(action as Item);
      newState.items = state.items;
      return newState;
    case const (ArticleAddItemAction):
      state.items?.add(action as Item);
      newState.items = state.items;
      return newState;
    default:
      return newState;
  }
}
