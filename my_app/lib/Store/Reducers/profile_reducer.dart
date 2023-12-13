import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/profile_state.dart';

ProfileState profileReducer(ProfileState state, dynamic action) {
  final ProfileState newState = state;
  switch (action.runtimeType) {
    case ProfileLastItemsBoughtListAction:
      newState.lastItemsBought = action.items;
      return newState;
    case ProfileUserInfosAction:
      newState.userInfos = action.userInfos;
      return newState;
    case ProfileUUIDAction:
      newState.uuid = action.uuid;
      return newState;
    case ProfileSetUserUUIDAction:
      newState.uuid = action.uuid;
      return newState;
    case ProfileChangeUserPictureAction:
      newState.userInfos!.profilePicture = action.picture;
      return newState;
    default:
      return newState;
  }
}
