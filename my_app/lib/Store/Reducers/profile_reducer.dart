import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/profile_state.dart';

/// The profile reducer
ProfileState profileReducer(ProfileState state, dynamic action) {
  final ProfileState newState = state;
  switch (action.runtimeType) {
    case const (ProfileLastItemsBoughtListAction):
      newState.lastItemsBought = action.items;
      return newState;
    case const (ProfileUserInfosAction):
      newState.userInfos = action.userInfos;
      return newState;
    case const (ProfileUUIDAction):
      newState.uuid = action.uuid;
      return newState;
    case const (ProfileSetUserUUIDAction):
      newState.uuid = action.uuid;
      return newState;
    case const (ProfileChangeUserPictureAction):
      newState.userInfos!.profilePicture = action.picture;
      return newState;
    default:
      return newState;
  }
}
