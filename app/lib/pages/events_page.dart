import 'package:baby_guard/blocs/event/event_bloc.dart';
import 'package:baby_guard/blocs/event/event_event.dart';
import 'package:baby_guard/blocs/event/event_state.dart';
import 'package:baby_guard/blocs/notification/notification_bloc.dart';
import 'package:baby_guard/blocs/notification/notification_state.dart';
import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/modules/events/event_list_tile.dart';
import 'package:baby_guard/repositories/event_repository.dart';
import 'package:baby_guard/widgets/base_page_content_layout.dart';
import 'package:baby_guard/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventsPageParams {
  EventsPageParams({
    required this.sensor,
  });

  final Sensor sensor;
}

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  static const route = '/events';

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late final _eventBloc = EventBloc(
    eventRepository: RepositoryProvider.of<EventRepository>(context),
  );

  void _fetchEvents() {
    final params = getParams();

    if (params != null) {
      _eventBloc.add(ListEventsEvent(sensorId: params.sensor.id ?? 0));
    }
  }

  EventsPageParams? getParams() {
    return ModalRoute.of(context)?.settings.arguments as EventsPageParams?;
  }

  @override
  void initState() {
    super.initState();

    Future(() {
      _fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final sensor = getParams()?.sensor;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Eventos'),
            Text(
              sensor?.identifier ?? '',
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
            ),
          ],
        ),
      ),
      body: BlocListener<NotificationBloc, NotificationState>(
        listener: (context, state) {
          _fetchEvents();
        },
        child: BlocProvider<EventBloc>(
          create: (context) => _eventBloc,
          child: BasePageContentLayout(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Eventos',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<EventBloc, EventState>(
                  builder: (context, state) {
                    if (state is ListEventsErrorState) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(state.message),
                      );
                    }

                    if (state is ListEventsDoneState) {
                      if (state.events.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text('Nenhum evento foi adicionado ainda.'),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.events.length,
                        separatorBuilder: (context, index) {
                          return const Divider(height: 0, indent: 64);
                        },
                        itemBuilder: (context, index) {
                          return EventListTile(event: state.events[index]);
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
        ),
      ),
    );
  }
}
