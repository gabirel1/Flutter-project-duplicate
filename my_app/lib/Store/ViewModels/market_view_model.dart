import 'dart:developer';

import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/order_item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/Actions/market_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The market view model
class MarketViewModel {
  /// The market view model
  MarketViewModel({
    required this.items,
    required this.loadItems,
    required this.addItem,
  });

  /// The market view model factory
  factory MarketViewModel.factory(
    Store<AppState> store,
    FirestoreService firestore,
  ) {
    return MarketViewModel(
      items: store.state.market.items,
      loadItems: () async {
        final ItemList response = await firestore.getItems();
        store.dispatch(MarketItemsListAction(items: response));
      },
      addItem: (OrderItem item) async {
        //store.dispatch(BasketAddItemAction(item: item));
      },
    );
  }

  /// The items
  final List<Item> items;

  /// The load items
  final Function loadItems;

  /// The add item
  final Function addItem;
}
