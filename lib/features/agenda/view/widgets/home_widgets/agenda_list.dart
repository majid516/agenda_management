
import 'package:agenda_management/features/agenda/view/widgets/home_widgets/agenda_card.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaList extends StatelessWidget {
  final List<Agenda> agendas;

  const AgendaList({super.key, required this.agendas});

  @override
  Widget build(BuildContext context) {
   agendas.sort((a, b) => DateFormat('hh:mm a').parse(a.startTime)
    .compareTo(DateFormat('hh:mm a').parse(b.startTime)));


    return ListView.builder(
      itemCount: agendas.length,
      itemBuilder: (context, index) {
        final agenda = agendas[index];
      
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: AgendaCard(
              agendaItem: agenda,
              ),
        );
      },
    );
  }
}
