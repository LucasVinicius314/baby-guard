import 'package:baby_guard/blocs/sensor/sensor_bloc.dart';
import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/utils/formatting.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:baby_guard/widgets/auth_wrapper.dart';
import 'package:baby_guard/widgets/base_page_content_layout.dart';
import 'package:baby_guard/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  static const route = '/sensors';

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  Future<void> _create() async {
    await showDialog(
      context: context,
      builder: (context) {
        final formKey = GlobalKey<FormState>();

        final identifierController = TextEditingController();

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
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: identifierController,
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
                          if (formKey.currentState?.validate() != true) {
                            return;
                          }

                          final sensor = Sensor(
                            id: null,
                            updatedAt: null,
                            createdAt: null,
                            userId: null,
                            alias: null,
                            identifier: identifierController.text,
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
      },
    );
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<SensorBloc>(context).add(ListSensorsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      floatingActionButton: FloatingActionButton(
        onPressed: _create,
        child: const Icon(Icons.add),
      ),
      child: BasePageContentLayout(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sensores',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocConsumer<SensorBloc, SensorState>(
              listener: (context, state) {
                if (state is CreateSensorDoneState) {
                  BlocProvider.of<SensorBloc>(context).add(ListSensorsEvent());
                }

                if (state is DeleteSensorDoneState) {
                  BlocProvider.of<SensorBloc>(context).add(ListSensorsEvent());
                }
              },
              builder: (context, state) {
                if (state is ListSensorsErrorState) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(state.message),
                  );
                }

                if (state is ListSensorsDoneState) {
                  if (state.sensors.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Nenhum sensor foi adicionado ainda.'),
                    );
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: state.sensors.length,
                    separatorBuilder: (context, index) {
                      return const Divider(height: 0, indent: 64);
                    },
                    itemBuilder: (context, index) {
                      final sensor = state.sensors[index];

                      final date = Formatting.date(
                        Utils.dateTimeFromString(sensor.createdAt),
                        mode: DateFormattingMode.slashSeparatedLong,
                      );

                      // TODO: fix, extract
                      return ListTile(
                        title: Text(sensor.identifier ?? ''),
                        leading: const Icon(Icons.sensors),
                        subtitle: Text('Adicionado em $date'),
                        onTap: () {
                          // TODO: fix
                        },
                        onLongPress: () async {
                          await showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            builder: (context) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'Remover sensor',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Deseja remover o sensor ${sensor.identifier ?? ''}? Esta ação não pode ser desfeita.',
                                        ),
                                        const SizedBox(height: 16),
                                        IntrinsicHeight(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Expanded(
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.redAccent,
                                                  ),
                                                  onPressed: state
                                                          is DeleteSensorLoadingState
                                                      ? null
                                                      : () async {
                                                          await Utils
                                                              .popNavigation(
                                                            context,
                                                          );
                                                        },
                                                  child:
                                                      const Icon(Icons.close),
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: OutlinedButton(
                                                  style:
                                                      OutlinedButton.styleFrom(
                                                    foregroundColor:
                                                        Colors.greenAccent,
                                                  ),
                                                  onPressed: state
                                                          is DeleteSensorLoadingState
                                                      ? null
                                                      : () {
                                                          BlocProvider.of<
                                                                      SensorBloc>(
                                                                  context)
                                                              .add(DeleteSensorEvent(
                                                                  sensor:
                                                                      sensor));
                                                        },
                                                  child:
                                                      const Icon(Icons.check),
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
                            },
                          );
                        },
                      );
                    },
                  );
                }

                return const LoadingIndicator();
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
