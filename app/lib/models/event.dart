import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Event {
  Event({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.sensorId,
  });

  int? id;
  String? updatedAt;
  String? createdAt;
  int? sensorId;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}
