import 'package:baby_guard/models/event.dart';
import 'package:baby_guard/utils/formatting.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:flutter/material.dart';

class EventListTile extends StatelessWidget {
  const EventListTile({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    final date = Formatting.date(
      Utils.dateTimeFromString(event.createdAt),
      mode: DateFormattingMode.slashSeparatedLong,
    );

    return ListTile(
      title: const Text('Detecção'),
      leading: const Icon(Icons.sensors),
      subtitle: Text('Disparado em $date'),
    );
  }
}
