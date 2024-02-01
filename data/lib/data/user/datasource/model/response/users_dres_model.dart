import 'package:json_annotation/json_annotation.dart';

part 'users_dres_model.g.dart';

@JsonSerializable()
class UsersDResModel {
  final int id;
  final String name;
  UsersDResModel({
    required this.id,
    required this.name,
  });

  factory UsersDResModel.fromJson(Map<String, dynamic> json) =>
      _$UsersDResModelFromJson(json);
}
