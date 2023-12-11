import 'package:my_app/Models/item.dart';
import 'package:my_app/Store/Actions/article_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class ArticleViewModel {
  ArticleViewModel({
    required this.items,
    required this.addCart,
  });

  factory ArticleViewModel.factory(Store<AppState> store) {
    return ArticleViewModel(
      items: store.state.article.items,
      addCart: (Item item) {
        store.dispatch(ArticleAddItemAction(item: item));
      },
    );
  }

  final List<Item>? items;
  final Function addCart;
}
