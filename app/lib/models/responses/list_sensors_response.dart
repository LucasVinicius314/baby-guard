import 'package:baby_guard/models/sensor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_sensors_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.none, explicitToJson: true)
class ListSensorsResponse {
  ListSensorsResponse({
    required this.sensors,
  });

  List<Sensor>? sensors;

  factory ListSensorsResponse.fromJson(Map<String, dynamic> json) =>
      _$ListSensorsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListSensorsResponseToJson(this);
}
