import 'package:my_app/Store/Actions/profile_actions.dart';
import 'package:my_app/Store/State/profile_state.dart';

/// The profile reducer
ProfileState profileReducer(ProfileState state, dynamic action) {
  final ProfileState newState = state;
  switch (action) {
    case final ProfileLastItemsBoughtListAction action:
      newState.lastItemsBought = action.items;
      return newState;
    case final ProfileUserInfosAction action:
      newState.userInfos = action.userInfos;
      return newState;
    case final ProfileUUIDAction action:
      newState.uuid = action.uuid;
      return newState;
    case final ProfileSetUserUUIDAction action:
      newState.uuid = action.uuid;
      return newState;
    case final ProfileChangeUserPictureAction action:
      newState.userInfos!.profilePicture = action.picture;
      return newState;
    case final ProfileLastOrdersAction action:
      newState.orders = action.orders;
      return newState;
    case final ProfileIsSellerAction action:
      newState.isSeller = action.isSeller;
      return newState;
    case final ProfileSellingItemsAction action:
      newState.sellingItems = action.sellingItems;
      return newState;
    default:
      return newState;
  }
}
