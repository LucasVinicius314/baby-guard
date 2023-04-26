import 'package:baby_guard/blocs/event/event_event.dart';
import 'package:baby_guard/blocs/event/event_state.dart';
import 'package:baby_guard/repositories/event_repository.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc({required this.eventRepository}) : super(EventInitialState()) {
    on<ListEventsEvent>((event, emit) async {
      try {
        emit(ListEventsLoadingState());

        final events =
            (await eventRepository.list(sensorId: event.sensorId)).events ?? [];

        emit(ListEventsDoneState(events: events));
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }

        emit(ListEventsErrorState(message: e.toString()));
      }
    });
  }

  final EventRepository eventRepository;
}
