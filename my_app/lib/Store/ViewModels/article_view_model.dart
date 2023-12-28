import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/order_item.dart';
// import 'package:my_app/Store/Actions/article_actions.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The article view model
class ArticleViewModel {
  /// The article view model
  ArticleViewModel({
    required this.addCart,
  });

  /// The article view model factory
  factory ArticleViewModel.factory(Store<AppState> store) {
    return ArticleViewModel(
      addCart: (Item item) {
        store.dispatch(
          BasketAddItemAction(orderItem: OrderItem(item: item, quantity: 1)),
        );
        //..dispatch(ArticleAddItemAction(item: item));
      },
    );
  }

  /// The add cart
  final Function addCart;
}
