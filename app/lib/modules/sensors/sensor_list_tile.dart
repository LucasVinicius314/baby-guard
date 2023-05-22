import 'package:baby_guard/models/sensor.dart';
import 'package:baby_guard/modules/sensors/delete_sensor_modal_bottom_sheet.dart';
import 'package:baby_guard/modules/sensors/update_sensor_modal_bottom_sheet.dart';
import 'package:baby_guard/pages/events_page.dart';
import 'package:baby_guard/utils/formatting.dart';
import 'package:baby_guard/utils/utils.dart';
import 'package:flutter/material.dart';

class SensorListTile extends StatefulWidget {
  const SensorListTile({
    super.key,
    required this.sensor,
  });

  final Sensor sensor;

  @override
  State<SensorListTile> createState() => _SensorListTileState();
}

class _SensorListTileState extends State<SensorListTile> {
  Future<void> _showMenu() async {
    const offset = Offset.zero;

    final renderBox = context.findRenderObject() as RenderBox;

    final overlay =
        Navigator.of(context).overlay!.context.findRenderObject() as RenderBox;

    final ans = await showMenu(
      context: context,
      clipBehavior: Clip.antiAlias,
      items: const [
        PopupMenuItem(value: 0, child: Text('Editar')),
        PopupMenuItem(value: 1, child: Text('Excluir')),
      ],
      position: RelativeRect.fromRect(
        Rect.fromPoints(
          renderBox.localToGlobal(offset, ancestor: overlay),
          renderBox.localToGlobal(
            renderBox.size.bottomRight(Offset.zero) + offset,
            ancestor: overlay,
          ),
        ),
        Offset.zero & overlay.size,
      ),
    );

    if (!mounted) {
      return;
    }

    if (ans == 0) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return UpdateSensorModalBottomSheet(sensor: widget.sensor);
        },
      );
    } else if (ans == 1) {
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) {
          return DeleteSensorModalBottomSheet(sensor: widget.sensor);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = Formatting.date(
      Utils.dateTimeFromString(widget.sensor.createdAt),
      mode: DateFormattingMode.slashSeparatedLong,
    );

    return ListTile(
      title: Text(widget.sensor.identifier ?? ''),
      leading: const Icon(Icons.sensors),
      subtitle: Text('Adicionado em $date'),
      onTap: () async {
        await Utils.pushNavigation(
          context,
          '/events',
          arguments: EventsPageParams(sensor: widget.sensor),
        );
      },
      onLongPress: _showMenu,
    );
  }
}
