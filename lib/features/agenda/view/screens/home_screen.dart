import 'package:agenda_management/features/agenda/view/widgets/home_widgets/agenda_list.dart';
import 'package:agenda_management/features/agenda/view/widgets/home_widgets/home_screen_app_bar.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_notifier.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AgendaHomeScreen extends ConsumerStatefulWidget {
  const AgendaHomeScreen({super.key});

  @override
  ConsumerState<AgendaHomeScreen> createState() => _AgendaHomeScreenState();
}

class _AgendaHomeScreenState extends ConsumerState<AgendaHomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(agendaProvider.notifier).fetchAgendas());
  }

  @override
  Widget build(BuildContext context) {
    final agendaState = ref.watch(agendaProvider);

    Map<String, List<Agenda>> groupedAgendas = {};
    for (var agenda in agendaState.agendas) {
      String formattedDate = DateFormat('d MMM').format(agenda.date);
      if (!groupedAgendas.containsKey(formattedDate)) {
        groupedAgendas[formattedDate] = [];
      }
      groupedAgendas[formattedDate]!.add(agenda);
    }
    List<String> dates = groupedAgendas.keys.toList();
    final dateFormat = DateFormat('d MMM');
    dates.sort((a, b) => dateFormat.parse(a).compareTo(dateFormat.parse(b)));

    return DefaultTabController(
      length: dates.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: HomeScreenAppBar(dates: dates),
        ),
        backgroundColor: Colors.grey[200],
        body: dates.isEmpty
            ? Center(
                child: Text(
                'No Agenda Scheduled',
                style: TextStyle(fontSize: 20, color: Colors.grey.shade500),
              ))
            : TabBarView(
                children: dates.map((date) {
                  return AgendaList(agendas: groupedAgendas[date]!);
                }).toList(),
              ),
      ),
    );
  }
}
