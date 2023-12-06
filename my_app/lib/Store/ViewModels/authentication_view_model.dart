import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class AuthenticationViewModel {
  AuthenticationViewModel({required this.uuid, required this.login});

  factory AuthenticationViewModel.factory(Store<AppState> store) {
    // use store
    return AuthenticationViewModel(
      uuid: store.state.authentication.uuid!,
      login: (String uuid) {
        store.dispatch(ProfileSetUserUUIDAction(uuid: uuid));
      },
    );
  }

  final String uuid;
  final Function login;
  // final Function loginWithGoogle;
}
