import 'package:my_app/Models/item.dart';
import 'package:my_app/Models/my_orders.dart';
import 'package:my_app/Models/user_infos.dart';

/// The profile last items bought list action
class ProfileLastItemsBoughtListAction {
  /// The profile last items bought list action
  ProfileLastItemsBoughtListAction({required this.items});

  /// The items list
  ItemList items;
}

/// The profile user infos action
class ProfileUserInfosAction {
  /// The profile user infos action
  ProfileUserInfosAction({required this.userInfos});

  /// The user infos
  UserInfos userInfos;
}

/// The profile uuid action
class ProfileUUIDAction {
  /// The profile uuid action
  ProfileUUIDAction({required this.uuid});

  /// The uuid
  String uuid;
}

/// The profile set user uuid action
class ProfileSetUserUUIDAction {
  /// The profile set user uuid action
  ProfileSetUserUUIDAction({required this.uuid});

  /// The uuid
  String uuid;
}

/// The profile change user picture action
class ProfileChangeUserPictureAction {
  /// The profile change user picture action
  ProfileChangeUserPictureAction({required this.picture});

  /// The picture
  String picture;
}

/// The profile last orders
class ProfileLastOrdersAction {
  /// The profile last orders
  ProfileLastOrdersAction({required this.orders});

  /// The orders
  OrderList orders;
}
