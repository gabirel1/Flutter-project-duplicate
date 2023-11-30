import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class AuthenticationViewModel {
  AuthenticationViewModel();

  factory AuthenticationViewModel.factory(Store<AppState> store) {
    // use store
    store.state;
    return AuthenticationViewModel();
  }
}
