import 'package:json_annotation/json_annotation.dart';

part 'user_infos.g.dart';

@JsonSerializable()
class UserInfos {
  UserInfos({
    required this.uuid,
    required this.email,
    required this.profilePicture,
    required this.isSeller,
  });

  factory UserInfos.fromJson(Map<String, dynamic> json) =>
      _$UserInfosFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfosToJson(this);

  String uuid = '';
  String email = '';
  String profilePicture = '';
  bool isSeller = false;
}
