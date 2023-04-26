// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_events_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListEventsResponse _$ListEventsResponseFromJson(Map<String, dynamic> json) =>
    ListEventsResponse(
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListEventsResponseToJson(ListEventsResponse instance) =>
    <String, dynamic>{
      'events': instance.events?.map((e) => e.toJson()).toList(),
    };
