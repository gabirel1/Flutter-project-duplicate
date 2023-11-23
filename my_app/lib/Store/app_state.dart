

import 'package:my_app/Reducers/app_reducer.dart';

import 'package:my_app/Store/basket_state.dart';
import 'package:redux/redux.dart';

final Store<AppState> store = Store<AppState>(
  appReducer, initialState: AppState.initial(),
);

class AppState {

  AppState({
    required this.basket,
  });

  factory AppState.initial() => AppState(basket: BasketState.initial());
  final BasketState basket;

  AppState copyWith({
    BasketState? basket,
  }) {
    return AppState(
      basket: basket ?? this.basket,
    );
  }
}
