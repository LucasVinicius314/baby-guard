import 'package:baby_guard/blocs/sensor/sensor_bloc.dart';
import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// TODO: fix, use a modal bottom sheet instead of this
class CreateSensorDialog extends StatelessWidget {
  CreateSensorDialog({super.key});

  final _formKey = GlobalKey<FormState>();

  final _identifierController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorBloc, SensorState>(
      listener: (context, state) async {
        if (state is CreateSensorDoneState) {
          await Utils.popNavigation(context);
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Criar sensor'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _identifierController,
                  decoration: const InputDecoration(
                    labelText: 'Identificador',
                  ),
                  validator: (value) {
                    value ??= '';

                    if (value.length < 3) {
                      return 'Identificador muito curto.';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: state is CreateSensorLoadingState
                  ? null
                  : () {
                      if (_formKey.currentState?.validate() != true) {
                        return;
                      }

                      final sensor = Sensor(
                        id: null,
                        updatedAt: null,
                        createdAt: null,
                        userId: null,
                        alias: null,
                        identifier: _identifierController.text,
                      );

                      BlocProvider.of<SensorBloc>(context)
                          .add(CreateSensorEvent(sensor: sensor));
                    },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
