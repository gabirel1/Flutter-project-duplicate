import 'package:my_app/Models/dialog_notif.dart';
import 'package:my_app/Models/my_error.dart';

/// The authentication set user uuid action
class AuthenticationSetUserUUIDAction {
  /// Set the user uuid
  AuthenticationSetUserUUIDAction({required this.uuid});

  /// The user uuid
  final String uuid;
}

/// The authentication set error action
class AuthenticationSetErrorAction {
  /// Set the error
  AuthenticationSetErrorAction({required this.error});

  /// The error
  final MyError error;
}

/// The authentication set dialog notif action
class AuthenticationSetDialogNotifAction {
  /// Set the dialog notif
  AuthenticationSetDialogNotifAction({required this.dialogNotif});

  /// The dialog notif
  final DialogNotif dialogNotif;
}
