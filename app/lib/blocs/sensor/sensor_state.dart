import 'package:baby_guard/models/sensor.dart';

abstract class SensorState {}

class SensorInitialState extends SensorState {}

// CreateSensor

class CreateSensorLoadingState extends SensorState {}

class CreateSensorDoneState extends SensorState {
  CreateSensorDoneState({
    required this.sensor,
  });

  final Sensor sensor;
}

class CreateSensorErrorState extends SensorState {
  CreateSensorErrorState({
    required this.message,
  });

  final String message;
}

// DeleteSensor

class DeleteSensorLoadingState extends SensorState {}

class DeleteSensorDoneState extends SensorState {
  DeleteSensorDoneState({
    required this.sensor,
  });

  final Sensor sensor;
}

class DeleteSensorErrorState extends SensorState {
  DeleteSensorErrorState({
    required this.message,
  });

  final String message;
}

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
