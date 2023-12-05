import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class AuthenticationViewModel {
  AuthenticationViewModel({required this.uuid});

  factory AuthenticationViewModel.factory(Store<AppState> store) {
    // use store
    return AuthenticationViewModel(uuid: store.state.authentication.uuid!);
  }

  final String uuid;
}
