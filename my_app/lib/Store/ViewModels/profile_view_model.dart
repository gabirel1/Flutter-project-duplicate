import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/Models/user_infos.dart';
import 'package:my_app/Repository/firestore_service.dart';
import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/app_state.dart';
import 'package:redux/redux.dart';

class ProfileViewModel {
  ProfileViewModel({
    required this.userInfos,
    required this.loadUserInfo,
    required this.changeUserPicture,
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
      changeUserPicture: () async {
        final ImagePicker picker = ImagePicker();
        final XFile? image =
            await picker.pickImage(source: ImageSource.gallery);
        if (image != null) {
          final (bool, String) res = await firestore.addPictureToStorage(image);
          if (res.$1 == true) {
            final bool res2 = await firestore.changeUserProfilePicture(
              store.state.profile.uuid == ' '
                  ? userUUID
                  : store.state.profile.uuid,
              res.$2,
            );
            if (res2) {
              store.dispatch(ProfileChangeUserPictureAction(picture: res.$2));
              debugPrint('User profile picture changed');
            }
          }
        }
      },
      userInfos: store.state.profile.userInfos!,
    );
  }

  final UserInfos? userInfos;
  // final List<String> foo;
  final Function loadUserInfo;
  final Function changeUserPicture;
  final Function signOut;
  final String uuid;
}
