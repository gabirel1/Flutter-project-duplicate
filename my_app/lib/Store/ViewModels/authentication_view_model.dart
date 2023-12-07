import 'package:flutter/material.dart';
import 'package:my_app/Models/dialog_notif.dart';
import 'package:my_app/Models/my_error.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/authentication_actions.dart';
import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class AuthenticationViewModel {
  AuthenticationViewModel({
    required this.uuid,
    required this.login,
    required this.loginWithGoogle,
    required this.registerWithGoogle,
    required this.handleLogIn,
    required this.handleRegister,
    this.error,
    this.dialogNotif,
  });

  factory AuthenticationViewModel.factory(Store<AppState> store) {
    // use store
    return AuthenticationViewModel(
      uuid: store.state.authentication.uuid!,
      login: (String uuid) {
        store.dispatch(ProfileSetUserUUIDAction(uuid: uuid));
      },
      loginWithGoogle: () async {
        final (bool, String) res = await FirestoreService().handleGoogleLogin();
        debugPrint('loginWithGoogle: $res');
        if (res.$1 == true) {
          store.dispatch(ProfileSetUserUUIDAction(uuid: res.$2));
        } else {
          final MyError errorRes =
              MyError(message: 'LoginWithGoogle', code: res.$2);
          store.dispatch(AuthenticationSetErrorAction(error: errorRes));
        }
        return res.$1;
      },
      registerWithGoogle: () async {
        final bool res = await FirestoreService().handleGoogleRegister();
        debugPrint('registerWithGoogle: $res');
        if (res == true) {
          final DialogNotif dialogNotif =
              DialogNotif(message: 'Successfully registered !');
          store.dispatch(
            AuthenticationSetDialogNotifAction(dialogNotif: dialogNotif),
          );
        } else {
          final MyError errorRes = MyError(
            message:
                'Error while registering, try again later !\nCheck if you are already registered with this Google account.',
            code: 'Error',
          );
          store.dispatch(AuthenticationSetErrorAction(error: errorRes));
        }
        return res;
      },
      handleLogIn: (String email, String password) async {
        final (bool, String, String) res =
            await FirestoreService().handleLogin(email, password);
        debugPrint('handleLogIn: $res');
        if (res.$1 == true) {
          final DialogNotif dialogNotif =
              DialogNotif(message: 'Successfully logged in !');
          store
            ..dispatch(
              AuthenticationSetDialogNotifAction(dialogNotif: dialogNotif),
            )
            ..dispatch(
              ProfileSetUserUUIDAction(uuid: res.$3),
            );
          return true;
        } else {
          final MyError errorRes = MyError(message: res.$2, code: 'Error');
          store.dispatch(AuthenticationSetErrorAction(error: errorRes));
          return false;
        }
      },
      handleRegister: (
        String email,
        String password,
        String confirmPassword,
        bool isSeller,
      ) async {
        final (bool, String) res = await FirestoreService().handleRegister(
          email,
          password,
          confirmPassword,
          wantToBeSeller: isSeller,
        );
        debugPrint('handleRegister: $res');
        if (res.$1 == true) {
          final DialogNotif dialogNotif =
              DialogNotif(message: 'Successfully registered !\nPlease log in');
          store.dispatch(
            AuthenticationSetDialogNotifAction(dialogNotif: dialogNotif),
          );
          return true;
        } else {
          final MyError errorRes = MyError(message: res.$2, code: 'Error');
          store.dispatch(AuthenticationSetErrorAction(error: errorRes));
          return false;
        }
      },
      error: store.state.authentication.error,
      dialogNotif: store.state.authentication.dialogNotif,
    );
  }

  final String uuid;
  final Function login;
  final Function loginWithGoogle;
  final Function registerWithGoogle;
  final Function handleLogIn;
  final Function handleRegister;
  final MyError? error;
  final DialogNotif? dialogNotif;
}
