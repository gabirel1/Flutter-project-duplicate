import 'package:flutter/cupertino.dart';
import 'package:my_app/Store/State/basket_state.dart';
import 'package:my_app/Store/State/home_state.dart';

@immutable
class AppState {
  const AppState({
    required this.home,
    required this.basket,
  });

  factory AppState.initial() => AppState(
      home: HomeState.initial(),
      basket: BasketState.initial()
  );
  final HomeState home;
  final BasketState basket;

  AppState copyWith({
    HomeState? home,
    BasketState? basket,
  }) {
    return AppState(
      home: home ?? this.home,
      basket: basket ?? this.basket,
    );
  }
}
