import 'package:baby_guard/models/event.dart';

abstract class EventState {}

class EventInitialState extends EventState {}

// ListEvents

class ListEventsLoadingState extends EventState {}

class ListEventsDoneState extends EventState {
  ListEventsDoneState({
    required this.events,
  });

  final List<Event> events;
}

class ListEventsErrorState extends EventState {
  ListEventsErrorState({
    required this.message,
  });

  final String message;
}
