import 'package:baby_guard/models/responses/list_sensors_response.dart';
import 'package:baby_guard/utils/api.dart';

class SensorRepository {
  const SensorRepository({required this.api});

  final Api api;

  Future<ListSensorsResponse> list() async {
    final req = api.get(
      path: '/api/v1/sensor/',
    );

    final data = await req;

    final res = ListSensorsResponse.fromJson(data);

    return res;
  }
}
