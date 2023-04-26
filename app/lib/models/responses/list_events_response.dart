import 'package:baby_guard/models/event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_events_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class ListEventsResponse {
  ListEventsResponse({
    required this.events,
  });

  List<Event>? events;

  factory ListEventsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListEventsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListEventsResponseToJson(this);
}
