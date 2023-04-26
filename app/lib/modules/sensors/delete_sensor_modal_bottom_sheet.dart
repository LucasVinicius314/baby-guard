import 'package:baby_guard/blocs/sensor/sensor_bloc.dart';
import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteSensorModalBottomSheet extends StatelessWidget {
  const DeleteSensorModalBottomSheet({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorBloc, SensorState>(
      listener: (context, state) async {
        if (state is DeleteSensorDoneState) {
          await Utils.popNavigation(context);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Remover sensor',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Deseja remover o sensor ${sensor.identifier ?? ''}? Esta ação não pode ser desfeita.',
              ),
              const SizedBox(height: 16),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                        ),
                        onPressed: state is DeleteSensorLoadingState
                            ? null
                            : () async {
                                await Utils.popNavigation(context);
                              },
                        child: const Icon(Icons.close),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.greenAccent,
                        ),
                        onPressed: state is DeleteSensorLoadingState
                            ? null
                            : () {
                                BlocProvider.of<SensorBloc>(context)
                                    .add(DeleteSensorEvent(sensor: sensor));
                              },
                        child: const Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
