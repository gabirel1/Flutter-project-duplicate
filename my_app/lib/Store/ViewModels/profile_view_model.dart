import 'package:my_app/Models/user_infos.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class ProfileViewModel {
  ProfileViewModel({
    required this.userInfos,
    required this.loadUserInfo,
    required this.uuid,
  });

  factory ProfileViewModel.factory(
    Store<AppState> store,
    FirestoreService firestore,
  ) {
    return ProfileViewModel(
      userInfos: store.state.profile.userInfos,
      loadUserInfo: () async {
        final UserInfos response = await firestore.getUserInfos('uuid');
        store.dispatch(ProfileUserInfosAction(userInfos: response));
      },
      uuid: store.state.profile.uuid,
    );
  }

  final UserInfos? userInfos;
  final Function loadUserInfo;
  final String? uuid;
}
