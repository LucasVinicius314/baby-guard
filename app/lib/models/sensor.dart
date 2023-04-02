import 'package:json_annotation/json_annotation.dart';

part 'sensor.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class Sensor {
  Sensor({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.userId,
    required this.alias,
    required this.identifier,
  });

  int? id;
  String? updatedAt;
  String? createdAt;
  int? userId;
  String? alias;
  String? identifier;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);

  Map<String, dynamic> toJson() => _$SensorToJson(this);
}
