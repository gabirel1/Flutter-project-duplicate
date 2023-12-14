import 'package:my_app/Store/Actions/authentication_actions.dart';
import 'package:my_app/Store/State/authentication_state.dart';

/// The authentication reducer
AuthenticationState authenticationReducer(
  AuthenticationState state,
  dynamic action,
) {
  final AuthenticationState newState = state;
  switch (action.runtimeType) {
    case const (AuthenticationSetUserUUIDAction):
      newState.uuid = action.uuid;
      return newState;
    case const (AuthenticationSetErrorAction):
      newState.error = action.error;
      return newState;
    case const (AuthenticationSetDialogNotifAction):
      newState.dialogNotif = action.dialogNotif;
      return newState;
    default:
      return newState;
  }
}
