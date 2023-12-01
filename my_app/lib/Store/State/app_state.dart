import 'package:flutter/cupertino.dart';
import 'package:my_app/Store/State/authentication_state.dart';
import 'package:my_app/Store/State/basket_state.dart';
import 'package:my_app/Store/State/home_state.dart';
import 'package:my_app/Store/State/profile_state.dart';

@immutable
class AppState {
  const AppState({
    required this.home,
    required this.basket,
    required this.profile,
    required this.authentication,
  });

  factory AppState.initial() => AppState(
        home: HomeState.initial(),
        basket: BasketState.initial(),
        profile: ProfileState.initial(),
        authentication: AuthenticationState.initial(),
      );
  final HomeState home;
  final BasketState basket;
  final ProfileState profile;
  final AuthenticationState authentication;

  AppState copyWith({
    required HomeState home,
    required BasketState basket,
    required ProfileState profile,
    required AuthenticationState authentication,
  }) {
    return AppState(
      home: home,
      basket: basket,
      profile: profile,
      authentication: authentication,
    );
  }
}
