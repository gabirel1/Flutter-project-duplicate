import 'package:my_app/Models/Item.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class HomeViewModel {

  HomeViewModel({required this.items, required this.loadItems});

  factory HomeViewModel.factory(Store<AppState> store) {
    return HomeViewModel(
      items: store.state.home.items,
      loadItems: () async {

      },
    );
  }

  final List<ItemModel>? items;
  final Function loadItems;

}
