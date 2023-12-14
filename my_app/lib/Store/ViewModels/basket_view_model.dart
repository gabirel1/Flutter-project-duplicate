import 'package:my_app/Models/item.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The basket view model
class BasketViewModel {
  /// The basket view model
  BasketViewModel({
    required this.items,
    required this.addCart,
  });

  /// The basket view model factory
  factory BasketViewModel.factory(Store<AppState> store) {
    return BasketViewModel(
      items: store.state.basket.items,
      addCart: (Item item) {
        store.dispatch(BasketAddItemAction(item: item));
      },
    );
  }

  /// The items
  final List<Item>? items;

  /// The add cart
  final Function addCart;
}
