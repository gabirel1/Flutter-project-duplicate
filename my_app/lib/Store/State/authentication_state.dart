import 'package:my_app/Models/dialog_notif.dart';
import 'package:my_app/Models/my_error.dart';

/// The authentication state
class AuthenticationState {
  /// The authentication state
  AuthenticationState({
    this.uuid,
    this.error,
  });

  /// The authentication state initial
  factory AuthenticationState.initial() => AuthenticationState(
        uuid: ' ',
      );

  /// The user uuid
  String? uuid;

  /// The error
  MyError? error;

  /// The dialog notif
  DialogNotif? dialogNotif;
}
