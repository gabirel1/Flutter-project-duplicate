import 'package:flutter/cupertino.dart';
import 'package:my_app/Store/State/article_state.dart';
import 'package:my_app/Store/State/authentication_state.dart';
import 'package:my_app/Store/State/basket_state.dart';
import 'package:my_app/Store/State/home_state.dart';
import 'package:my_app/Store/State/market_state.dart';
import 'package:my_app/Store/State/profile_state.dart';
import 'package:my_app/Store/State/qr_code_state.dart';

/// The app state
@immutable
class AppState {
  /// the required states
  const AppState({
    required this.home,
    required this.market,
    required this.basket,
    required this.profile,
    required this.authentication,
    required this.article,
    required this.qrCode,
  });

  /// The initial state. The blank one.
  factory AppState.initial() => AppState(
        home: HomeState.initial(),
        market: MarketState.initial(),
        basket: BasketState.initial(),
        profile: ProfileState.initial(),
        authentication: AuthenticationState.initial(),
        article: ArticleState.initial(),
        qrCode: QrCodeState.initial(),
      );

  /// The home state
  final HomeState home;

  /// The market state
  final MarketState market;

  /// The basket state
  final BasketState basket;

  /// The profile state
  final ProfileState profile;

  /// The authentication state
  final AuthenticationState authentication;

  /// The article state
  final ArticleState article;

  /// The qrCode state
  final QrCodeState qrCode;

  /// Copy the app state
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
