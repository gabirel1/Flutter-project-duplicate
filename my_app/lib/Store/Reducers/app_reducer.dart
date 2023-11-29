import 'package:my_app/Store/Reducers/basket_reducer.dart';
import 'package:my_app/Store/Reducers/home_reducer.dart';
import 'package:my_app/Store/Reducers/profile_reducer.dart';
import 'package:my_app/Store/State/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    home: homeReducer(state.home, action),
    basket: basketReducer(state.basket, action),
    profile: profileReducer(state.profile, action),
  );
}
