import 'package:baby_guard/models/responses/list_sensors_response.dart';
import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/utils/api.dart';

class SensorRepository {
  const SensorRepository({required this.api});

  final Api api;

  Future<void> create({required Sensor sensor}) async {
    final req = api.post(
      path: '/api/v1/sensor/',
      body: sensor.toJson(),
    );

    await req;
  }

  Future<void> update({required Sensor sensor}) async {
    final req = api.patch(
      path: '/api/v1/sensor/${sensor.id}',
      body: {
        'identifier': sensor.identifier,
      },
    );

    await req;
  }

  Future<void> delete({required Sensor sensor}) async {
    final req = api.delete(
      path: '/api/v1/sensor/${sensor.id}',
      body: {},
    );

    await req;
  }

  Future<ListSensorsResponse> list() async {
    final req = api.get(
      path: '/api/v1/sensor/',
    );

    final data = await req;

    final res = ListSensorsResponse.fromJson(data);

    return res;
  }
}
