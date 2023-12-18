import 'package:my_app/Store/Reducers/article_reducer.dart';
import 'package:my_app/Store/Reducers/authentication_reducer.dart';
import 'package:my_app/Store/Reducers/basket_reducer.dart';
import 'package:my_app/Store/Reducers/home_reducer.dart';
import 'package:my_app/Store/Reducers/market_reducer.dart';
import 'package:my_app/Store/Reducers/profile_reducer.dart';
import 'package:my_app/Store/Reducers/qr_code_reducer.dart';
import 'package:my_app/Store/State/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    home: homeReducer(state.home, action),
    market: marketReducer(state.market, action),
    basket: basketReducer(state.basket, action),
    profile: profileReducer(state.profile, action),
    authentication: authenticationReducer(state.authentication, action),
    article: articleReducer(state.article, action),
    qrCode: qrCodeReducer(state.qrCode, action),
  );
}
