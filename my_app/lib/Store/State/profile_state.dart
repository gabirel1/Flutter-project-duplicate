import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/user_infos.dart';

/// The profile state
class ProfileState {
  /// The profile state
  ProfileState({
    this.lastItemsBought,
    this.userInfos,
    this.uuid = ' ',
    // this.uuid = 'CI6MG2mmRnfz2uNCCFmNrW8Z1J83',
  });

  /// The profile state initial
  factory ProfileState.initial() => ProfileState(
        lastItemsBought: <Item>[],
        userInfos: UserInfos(
          uuid: ' ',
          email: '',
          profilePicture: '',
          isSeller: false,
          formatedEmail: '',
        ),
      );

  /// The last items bought
  List<Item>? lastItemsBought;

  /// The user infos
  UserInfos? userInfos;

  /// The uuid
  String uuid;
}
