import 'package:my_app/Store/State/authentication_state.dart';

AuthenticationState authenticationReducer(
  AuthenticationState state,
  dynamic action,
) {
  final AuthenticationState newState = state;
  switch (action.runtimeType) {
    default:
      return newState;
  }
}
