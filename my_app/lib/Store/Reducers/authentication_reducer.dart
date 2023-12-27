import 'package:my_app/Store/Actions/authentication_actions.dart';
import 'package:my_app/Store/State/authentication_state.dart';

/// The authentication reducer
AuthenticationState authenticationReducer(
  AuthenticationState state,
  dynamic action,
) {
  final AuthenticationState newState = state;
  switch (action) {
    case final AuthenticationSetUserUUIDAction action:
      newState.uuid = action.uuid;
      return newState;
    case final AuthenticationSetErrorAction action:
      newState.error = action.error;
      return newState;
    case final AuthenticationSetDialogNotifAction action:
      newState.dialogNotif = action.dialogNotif;
      return newState;
    default:
      return newState;
  }
}
