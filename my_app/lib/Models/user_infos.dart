import 'package:json_annotation/json_annotation.dart';

part 'user_infos.g.dart';

/// UserInfos is a class that represent an user
@JsonSerializable()
class UserInfos {
  /// UserInfos has an uuid, an email, a profile picture and a boolean to know if the user is a seller
  UserInfos({
    required this.uuid,
    required this.email,
    required this.profilePicture,
    required this.isSeller,
    required this.formatedEmail,
  });

  /// UserInfos from json
  factory UserInfos.fromJson(Map<String, dynamic> json) =>
      _$UserInfosFromJson(json);

  /// UserInfos to json
  Map<String, dynamic> toJson() => _$UserInfosToJson(this);

  /// UserInfos uuid
  String uuid = '';

  /// UserInfos email
  String email = '';

  /// UserInfos formated email
  String formatedEmail = '';

  /// UserInfos profile picture
  String profilePicture = '';

  /// UserInfos is seller
  bool isSeller = false;
}
