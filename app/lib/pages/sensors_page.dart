import 'package:baby_guard/blocs/sensor/sensor_bloc.dart';
import 'package:baby_guard/blocs/sensor/sensor_event.dart';
import 'package:baby_guard/blocs/sensor/sensor_state.dart';
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
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SensorBloc>(context).add(ListSensorsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
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
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<SensorBloc, SensorState>(
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

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: state.sensors.map((e) {
                      return ListTile(
                        title: Text(e.alias ?? ''),
                      );
                    }).toList(),
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
