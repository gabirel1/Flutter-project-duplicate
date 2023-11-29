import 'package:flutter/cupertino.dart';
import 'package:my_app/Store/State/basket_state.dart';
import 'package:my_app/Store/State/home_state.dart';
import 'package:my_app/Store/State/profile_state.dart';

@immutable
class AppState {
  const AppState({
    required this.home,
    required this.basket,
    required this.profile,
  });

  factory AppState.initial() => AppState(
        home: HomeState.initial(),
        basket: BasketState.initial(),
        profile: ProfileState.initial(),
      );
  final HomeState home;
  final BasketState basket;
  final ProfileState profile;

  AppState copyWith({
    required HomeState home,
    required BasketState basket,
    required ProfileState profile,
  }) {
    return AppState(
      home: home,
      basket: basket,
      profile: profile,
    );
  }
}
