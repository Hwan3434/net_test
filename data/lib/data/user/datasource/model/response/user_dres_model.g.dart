// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dres_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDResModel _$UserDResModelFromJson(Map<String, dynamic> json) =>
    UserDResModel(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String? ?? '',
    );

Map<String, dynamic> _$UserDResModelToJson(UserDResModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
    };
