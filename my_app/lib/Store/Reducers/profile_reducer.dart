import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/profile_state.dart';

/// The profile reducer
ProfileState profileReducer(ProfileState state, dynamic action) {
  final ProfileState newState = state;
  switch (action.runtimeType) {
    case ProfileLastItemsBoughtListAction _:
      newState.lastItemsBought = action.items;
      return newState;
    case ProfileUserInfosAction _:
      newState.userInfos = action.userInfos;
      return newState;
    case ProfileUUIDAction _:
      newState.uuid = action.uuid;
      return newState;
    case ProfileSetUserUUIDAction _:
      newState.uuid = action.uuid;
      return newState;
    case ProfileChangeUserPictureAction _:
      newState.userInfos!.profilePicture = action.picture;
      return newState;
    default:
      return newState;
  }
}
