

import 'package:my_app/Models/Item.dart';

class HomeState {

  HomeState({this.items});

  factory HomeState.initial() => HomeState(
      items: <ItemModel>[],
  );

  List<ItemModel>? items;
}
