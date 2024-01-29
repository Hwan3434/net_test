import 'package:json_annotation/json_annotation.dart';

part 'user_dres_model.g.dart';

@JsonSerializable()
class UserDResModel {
  final int id;
  final String name;
  final String username;
  @JsonKey(defaultValue: '', includeIfNull: false)
  final String email;
  UserDResModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
  });

  factory UserDResModel.fromJson(Map<String, dynamic> json) =>
      _$UserDResModelFromJson(json);
}
