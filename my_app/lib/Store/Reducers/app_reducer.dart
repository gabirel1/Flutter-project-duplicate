import 'package:my_app/Store/Reducers/basket_reducer.dart';
import 'package:my_app/Store/Reducers/market_reducer.dart';
import 'package:my_app/Store/State/app_state.dart';

import 'home_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    home: homeReducer(state.home, action),
    market: marketReducer(state.market, action),
    basket: basketReducer(state.basket, action),
  );
}
