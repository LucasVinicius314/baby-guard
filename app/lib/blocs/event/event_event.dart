abstract class EventEvent {}

class ListEventsEvent extends EventEvent {
  ListEventsEvent({
    required this.sensorId,
  });

  final int sensorId;
}
