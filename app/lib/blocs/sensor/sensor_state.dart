import 'package:baby_guard/models/sensor.dart';

abstract class SensorState {}

class SensorInitialState extends SensorState {}

// ListSensors

class ListSensorsLoadingState extends SensorState {}

class ListSensorsDoneState extends SensorState {
  ListSensorsDoneState({
    required this.sensors,
  });

  final List<Sensor> sensors;
}

class ListSensorsErrorState extends SensorState {
  ListSensorsErrorState({
    required this.message,
  });

  final String message;
}
