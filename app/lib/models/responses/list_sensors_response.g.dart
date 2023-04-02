// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_sensors_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListSensorsResponse _$ListSensorsResponseFromJson(Map<String, dynamic> json) =>
    ListSensorsResponse(
      sensors: (json['sensors'] as List<dynamic>?)
          ?.map((e) => Sensor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListSensorsResponseToJson(
        ListSensorsResponse instance) =>
    <String, dynamic>{
      'sensors': instance.sensors?.map((e) => e.toJson()).toList(),
    };
