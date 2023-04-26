import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/modules/sensors/delete_sensor_modal_bottom_sheet.dart';
import 'package:baby_guard/pages/events_page.dart';
import 'package:baby_guard/utils/formatting.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:flutter/material.dart';

class SensorListTile extends StatelessWidget {
  const SensorListTile({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  @override
  Widget build(BuildContext context) {
    final date = Formatting.date(
      Utils.dateTimeFromString(sensor.createdAt),
      mode: DateFormattingMode.slashSeparatedLong,
    );

    return ListTile(
      title: Text(sensor.identifier ?? ''),
      leading: const Icon(Icons.sensors),
      subtitle: Text('Adicionado em $date'),
      onTap: () async {
        await Utils.pushNavigation(
          context,
          '/events',
          arguments: EventsPageParams(sensor: sensor),
        );
      },
      onLongPress: () async {
        await showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return DeleteSensorModalBottomSheet(sensor: sensor);
          },
        );
      },
    );
  }
}
