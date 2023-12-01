import 'package:my_app/Store/Actions/authentication_actions.dart';
import 'package:my_app/Store/State/authentication_state.dart';

AuthenticationState authenticationReducer(
  AuthenticationState state,
  dynamic action,
) {
  final AuthenticationState newState = state;
  switch (action.runtimeType) {
    case AuthenticationSetUserUUIDAction:
      newState.uuid = action.uuid;
      return newState;
    default:
      return newState;
  }
}
