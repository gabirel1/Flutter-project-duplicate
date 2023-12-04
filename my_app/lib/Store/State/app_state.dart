import 'package:flutter/cupertino.dart';
import 'package:my_app/Store/State/basket_state.dart';
import 'package:my_app/Store/State/home_state.dart';
import 'package:my_app/Store/State/market_state.dart';

@immutable
class AppState {
  const AppState({
    required this.home,
    required this.market,
    required this.basket,
  });

  factory AppState.initial() => AppState(
      home: HomeState.initial(),
      market: MarketState.initial(),
      basket: BasketState.initial(),
  );

  final HomeState home;
  final MarketState market;
  final BasketState basket;

  AppState copyWith({
    required HomeState home,
    required MarketState market,
    required BasketState basket,
  }) {
    return AppState(
      home: home,
      market: market,
      basket: basket,
    );
  }
}
