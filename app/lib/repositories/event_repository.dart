import 'package:baby_guard/models/responses/list_events_response.dart';
import 'package:baby_guard/utils/api.dart';

class EventRepository {
  const EventRepository({required this.api});

  final Api api;

  Future<ListEventsResponse> list({
    required int sensorId,
  }) async {
    final req = api.get(
      path: '/api/v1/sensor/${sensorId.toStringAsFixed(0)}/event',
    );

    final data = await req;

    final res = ListEventsResponse.fromJson(data);

    return res;
  }
}
