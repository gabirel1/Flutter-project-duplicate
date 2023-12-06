import 'package:my_app/Models/item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/basket_actions.dart';
import 'package:my_app/Store/Actions/market_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class MarketViewModel {
  MarketViewModel({
    required this.items,
    required this.loadItems,
    required this.addItem,
  });

  factory MarketViewModel.factory(
      Store<AppState> store, FirestoreService firestore) {
    return MarketViewModel(
      items: store.state.market.items,
      loadItems: () async {
        final ItemList response = await firestore.getItems();
        store.dispatch(MarketItemsListAction(items: response));
      },
      addItem: (Item item) async {
        store.dispatch(BasketAddItemAction(item: item));
      },
    );
  }

  final List<Item> items;
  final Function loadItems;
  final Function addItem;
}
