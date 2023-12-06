import 'package:my_app/Models/my_error.dart';

class AuthenticationState {
  AuthenticationState({
    this.uuid,
    this.error,
  });

  factory AuthenticationState.initial() => AuthenticationState(
        uuid: ' ',
      );

  String? uuid;
  MyError? error;
}
