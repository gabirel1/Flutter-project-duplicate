import 'package:my_app/Models/Item.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';



class BasketViewModel {

  BasketViewModel({required this.items});

  factory BasketViewModel.factory(Store<AppState> store) {
    

    return BasketViewModel(items: store.state.basket.items);

  }

  final List<ItemModel>? items;

}
