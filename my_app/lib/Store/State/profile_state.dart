import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/user_infos.dart';

class ProfileState {
  ProfileState({
    this.lastItemsBought,
    this.userInfos,
    this.uuid,
  });

  factory ProfileState.initial() => ProfileState(
        lastItemsBought: <Item>[],
        userInfos: UserInfos(
          uuid: '',
          email: '',
          profilePicture: '',
          isSeller: false,
        ),
        uuid: '',
      );

  List<Item>? lastItemsBought;
  UserInfos? userInfos;
  String? uuid;
}
