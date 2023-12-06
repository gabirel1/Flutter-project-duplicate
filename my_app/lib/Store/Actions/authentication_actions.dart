import 'package:my_app/Models/my_error.dart';

class AuthenticationSetUserUUIDAction {
  AuthenticationSetUserUUIDAction({required this.uuid});

  final String uuid;
}

class AuthenticationSetErrorAction {
  AuthenticationSetErrorAction({required this.error});

  final MyError error;
}
