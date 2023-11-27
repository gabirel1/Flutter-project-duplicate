import 'package:my_app/Models/item.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/home_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class HomeViewModel {

  HomeViewModel({required this.items, required this.loadItems});

  factory HomeViewModel.factory(Store<AppState> store, FirestoreService firestore) {
    return HomeViewModel(
      items: store.state.home.items,
      loadItems: () async {
        final ItemList response = await firestore.getItems();
        store.dispatch(HomeItemsListAction(items: response));
      },
    );
  }

  final List<Item> items;
  final Function loadItems;

}
