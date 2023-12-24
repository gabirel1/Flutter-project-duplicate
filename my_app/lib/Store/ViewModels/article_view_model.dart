import 'package:my_app/Models/item.dart';
import 'package:my_app/Store/Actions/article_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The article view model
class ArticleViewModel {
  /// The article view model
  ArticleViewModel({
    required this.items,
    required this.addCart,
  });

  /// The article view model factory
  factory ArticleViewModel.factory(Store<AppState> store) {
    return ArticleViewModel(
      items: store.state.article.items,
      addCart: (Item item) {
        store.dispatch(ArticleAddItemAction(item: item));
      },
    );
  }

  /// The items
  final List<Item>? items;

  /// The add cart
  final Function addCart;
}
