import 'package:my_app/Store/Actions/authentication_actions.dart';
import 'package:my_app/Store/State/authentication_state.dart';

/// The authentication reducer
AuthenticationState authenticationReducer(
  AuthenticationState state,
  dynamic action,
) {
  final AuthenticationState newState = state;
  switch (action.runtimeType) {
    case AuthenticationSetUserUUIDAction _:
      newState.uuid = action.uuid;
      return newState;
    case AuthenticationSetErrorAction _:
      newState.error = action.error;
      return newState;
    case AuthenticationSetDialogNotifAction _:
      newState.dialogNotif = action.dialogNotif;
      return newState;
    default:
      return newState;
  }
}
