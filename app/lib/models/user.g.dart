// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String?,
      password: json['password'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'username': instance.username,
    };
