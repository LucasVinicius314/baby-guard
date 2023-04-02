import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
import 'package:baby_guard/repositories/sensor_repository.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SensorBloc extends Bloc<SensorEvent, SensorState> {
  SensorBloc({required this.sensorRepository}) : super(SensorInitialState()) {
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
