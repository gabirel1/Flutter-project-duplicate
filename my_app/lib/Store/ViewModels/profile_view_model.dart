import 'package:firebase_auth/firebase_auth.dart';
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
    required this.signOut,
  });

  factory ProfileViewModel.factory(
    Store<AppState> store,
    FirestoreService firestore,
  ) {
    final String userUUID = firestore.getCurrentUserUUID();

    return ProfileViewModel(
      uuid: (store.state.profile.uuid == ' ')
          ? userUUID
          : store.state.profile.uuid,
      loadUserInfo: () async {
        final UserInfos response = await firestore.getUserInfos(
          (store.state.profile.uuid == ' ')
              ? userUUID
              : store.state.profile.uuid,
        );
        // if (response.isSeller) {
        //   final List<String> foo = await firestore.getFoo();
        // }
        store.dispatch(ProfileUserInfosAction(userInfos: response));
      },
      signOut: () async {
        await FirebaseAuth.instance.signOut();
        store.dispatch(ProfileSetUserUUIDAction(uuid: ' '));
      },
      userInfos: store.state.profile.userInfos!,
    );
  }

  final UserInfos? userInfos;
  // final List<String> foo;
  final Function loadUserInfo;
  final Function signOut;
  final String uuid;
}
