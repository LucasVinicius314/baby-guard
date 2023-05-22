import 'package:baby_guard/blocs/sensor/sensor_bloc.dart';
import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateSensorModalBottomSheet extends StatefulWidget {
  const UpdateSensorModalBottomSheet({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  @override
  State<UpdateSensorModalBottomSheet> createState() =>
      _UpdateSensorModalBottomSheetState();
}

class _UpdateSensorModalBottomSheetState
    extends State<UpdateSensorModalBottomSheet> {
  final _formKey = GlobalKey<FormState>();

  final _identifierFocusNode = FocusNode();

  final _identifierController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _identifierController.text = widget.sensor.identifier ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SensorBloc, SensorState>(
      listener: (context, state) async {
        if (state is UpdateSensorDoneState) {
          await Utils.popNavigation(context);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Atualizar sensor',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  'Insira um novo nome para o sensor ${widget.sensor.identifier ?? ''}.',
                ),
                const SizedBox(height: 16),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          focusNode: _identifierFocusNode,
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
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.greenAccent,
                          ),
                          onPressed: state is UpdateSensorLoadingState
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() !=
                                      true) {
                                    return;
                                  }

                                  final newSensor = Sensor(
                                    id: widget.sensor.id,
                                    updatedAt: widget.sensor.updatedAt,
                                    createdAt: widget.sensor.createdAt,
                                    userId: widget.sensor.userId,
                                    alias: widget.sensor.alias,
                                    identifier: _identifierController.text,
                                  );

                                  BlocProvider.of<SensorBloc>(context).add(
                                      UpdateSensorEvent(sensor: newSensor));
                                },
                          child: const Icon(Icons.check),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
