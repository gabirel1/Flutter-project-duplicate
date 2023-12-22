import 'package:my_app/Models/item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/search_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

/// The search view model
class SearchViewModel {
  /// The search view model
  SearchViewModel({
    required this.items,
    required this.loadItems,
  });

  /// The search view model factory
  factory SearchViewModel.factory(
    Store<AppState> store,
    FirestoreService firestore,
  ) {
    return SearchViewModel(
      items: store.state.search.items,
      loadItems: () async {
        final ItemList response = await firestore.getItems();
        store.dispatch(SearchItemsListAction(items: response));
      },
    );
  }

  /// The items
  final List<Item> items;

  /// The load items
  final Function loadItems;
}
