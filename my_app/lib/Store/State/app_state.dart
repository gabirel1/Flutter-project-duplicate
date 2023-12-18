import 'package:flutter/cupertino.dart';
import 'package:my_app/Store/State/article_state.dart';
import 'package:my_app/Store/State/authentication_state.dart';
import 'package:my_app/Store/State/basket_state.dart';
import 'package:my_app/Store/State/home_state.dart';
import 'package:my_app/Store/State/market_state.dart';
import 'package:my_app/Store/State/profile_state.dart';
import 'package:my_app/Store/State/qr_code_state.dart';

@immutable
class AppState {
  const AppState({
    required this.home,
    required this.market,
    required this.basket,
    required this.profile,
    required this.authentication,
    required this.article,
    required this.qrCode,
  });

  factory AppState.initial() => AppState(
        home: HomeState.initial(),
        market: MarketState.initial(),
        basket: BasketState.initial(),
        profile: ProfileState.initial(),
        authentication: AuthenticationState.initial(),
        article: ArticleState.initial(),
        qrCode: QrCodeState.initial(),
      );

  final HomeState home;
  final MarketState market;
  final BasketState basket;
  final ProfileState profile;
  final AuthenticationState authentication;
  final ArticleState article;
  final QrCodeState qrCode;

  AppState copyWith({
    required HomeState home,
    required MarketState market,
    required BasketState basket,
    required ProfileState profile,
    required AuthenticationState authentication,
    required ArticleState article,
    required QrCodeState qrCode,
  }) {
    return AppState(
      home: home,
      market: market,
      basket: basket,
      profile: profile,
      authentication: authentication,
      article: article,
      qrCode: qrCode,
    );
  }
}
