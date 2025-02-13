import 'package:agenda_management/features/agenda/view/widgets/home_widgets/agenda_list_tile_elements.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaCard extends StatelessWidget {
  final Agenda agendaItem;
  

  const AgendaCard({
    super.key,
    required this.agendaItem,
   
  });

  @override
  Widget build(BuildContext context) {
   
    final DateTime now = DateTime.now();

    final DateTime agendaDate = agendaItem.date;
    final DateTime parsedStartTime =
        DateFormat('hh:mm a').parse(agendaItem.startTime);
    final DateTime parsedEndTime =
        DateFormat('hh:mm a').parse(agendaItem.endTime);
    final DateTime eventStart = DateTime(
      agendaDate.year,
      agendaDate.month,
      agendaDate.day,
      parsedStartTime.hour,
      parsedStartTime.minute,
    );
    final DateTime eventEnd = DateTime(
      agendaDate.year,
      agendaDate.month,
      agendaDate.day,
      parsedEndTime.hour,
      parsedEndTime.minute,
    );

    Color statusColor;
    Widget circle;

    if (now.isAfter(eventEnd) || now.isAtSameMomentAs(eventEnd)) {
      statusColor = Colors.blue;
      circle = const Icon(Icons.circle, color: Colors.blue, size: 13);
    } else if ((now.isAfter(eventStart) || now.isAtSameMomentAs(eventStart)) &&
        now.isBefore(eventEnd)) {
      statusColor = Colors.blue;
      circle = const Icon(Icons.circle_outlined, color: Colors.blue, size: 13);
    } else {
      statusColor = Colors.grey;
      circle = const Icon(Icons.circle_outlined, color: Colors.grey, size: 13);
    }
    return AgendaListTileElements(
      circle: circle,
      statusColor: statusColor,
      agendaItem: agendaItem,
    );
  }
}
