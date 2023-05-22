import 'package:baby_guard/blocs/sensor/sensor_bloc.dart';
import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
import 'package:baby_guard/modules/sensors/create_sensor_dialog.dart';
import 'package:baby_guard/modules/sensors/sensor_list_tile.dart';
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
        return CreateSensorDialog();
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

                if (state is UpdateSensorDoneState) {
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
                      return SensorListTile(sensor: state.sensors[index]);
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
