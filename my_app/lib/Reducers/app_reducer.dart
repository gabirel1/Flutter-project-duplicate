

import 'package:my_app/Reducers/basket_reducer.dart';
import 'package:my_app/Store/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(basket: basketReducer(state.basket, action));
}