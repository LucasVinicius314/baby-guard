// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'read_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReadUserResponse _$ReadUserResponseFromJson(Map<String, dynamic> json) =>
    ReadUserResponse(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReadUserResponseToJson(ReadUserResponse instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
    };
