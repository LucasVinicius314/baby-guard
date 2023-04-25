import 'package:baby_guard/models/sensor.dart';

abstract class SensorEvent {}

class CreateSensorEvent extends SensorEvent {
  CreateSensorEvent({
    required this.sensor,
  });

  final Sensor sensor;
}

class DeleteSensorEvent extends SensorEvent {
  DeleteSensorEvent({
    required this.sensor,
  });

  final Sensor sensor;
}

class ListSensorsEvent extends SensorEvent {}
