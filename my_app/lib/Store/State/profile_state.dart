import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/user_infos.dart';

class ProfileState {
  ProfileState({
    this.lastItemsBought,
    this.userInfos,
    this.uuid = ' ',
    // this.uuid = 'CI6MG2mmRnfz2uNCCFmNrW8Z1J83',
  });

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

  List<Item>? lastItemsBought;
  UserInfos? userInfos;
  String uuid;
}
