

import 'package:my_app/Models/item.dart';

class HomeState {

  HomeState({required this.items});

  factory HomeState.initial() => HomeState(
      items: <Item>[],
  );

  List<Item> items;
}
