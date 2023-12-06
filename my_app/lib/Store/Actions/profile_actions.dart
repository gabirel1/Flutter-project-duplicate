import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/user_infos.dart';

class ProfileLastItemsBoughtListAction {
  ProfileLastItemsBoughtListAction({required this.items});

  ItemList items;
}

class ProfileUserInfosAction {
  ProfileUserInfosAction({required this.userInfos});

  UserInfos userInfos;
}

class ProfileUUIDAction {
  ProfileUUIDAction({required this.uuid});

  String uuid;
}

class ProfileSetUserUUIDAction {
  ProfileSetUserUUIDAction({required this.uuid});

  String uuid;
}
