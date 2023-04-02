// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) => Sensor(
      id: json['id'] as int?,
      updatedAt: json['updatedAt'] as String?,
      createdAt: json['createdAt'] as String?,
      userId: json['userId'] as int?,
      alias: json['alias'] as String?,
      identifier: json['identifier'] as String?,
    );

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'id': instance.id,
      'updatedAt': instance.updatedAt,
      'createdAt': instance.createdAt,
      'userId': instance.userId,
      'alias': instance.alias,
      'identifier': instance.identifier,
    };
