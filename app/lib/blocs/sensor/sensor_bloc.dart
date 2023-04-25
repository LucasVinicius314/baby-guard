import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
import 'package:baby_guard/repositories/sensor_repository.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  SensorBloc({required this.sensorRepository}) : super(SensorInitialState()) {
    on<CreateSensorEvent>((event, emit) async {
      try {
        emit(CreateSensorLoadingState());

        await sensorRepository.create(sensor: event.sensor);

        emit(CreateSensorDoneState(sensor: event.sensor));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(CreateSensorErrorState(message: e.toString()));
      }
    });

    on<DeleteSensorEvent>((event, emit) async {
      try {
        emit(DeleteSensorLoadingState());

        await sensorRepository.delete(sensor: event.sensor);

        emit(DeleteSensorDoneState(sensor: event.sensor));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(DeleteSensorErrorState(message: e.toString()));
      }
    });

    on<ListSensorsEvent>((event, emit) async {
      try {
        emit(ListSensorsLoadingState());

        final sensors = (await sensorRepository.list()).sensors ?? [];

        emit(ListSensorsDoneState(sensors: sensors));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(ListSensorsErrorState(message: e.toString()));
      }
    });
  }

  final SensorRepository sensorRepository;
}
