import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:agenda_management/features/agenda/services/agenda_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';


class Agenda {
  final DateTime date;
  final String title;
  final String time;
  final String startTime;
  final String endTime;
  final List<String> members;

  Agenda({
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.title,
    required this.time,
    required this.members,
  });

  // Convert from AgendaModel (Hive) to Agenda
  factory Agenda.fromModel(AgendaModel model) {
    return Agenda(
      date: DateFormat('MM/dd/yyyy').parse(model.date),
      title: model.title,
      time: "${model.startingTime} - ${model.endingTime}",
      startTime: model.startingTime,
      endTime: model.endingTime,
      members: model.members,
    );
  }
}

// Agenda state class
class AgendaState {
  final List<Agenda> agendas;
  final bool isLoading;
  final String errorMessage;

  AgendaState({
    required this.agendas,
    this.isLoading = false,
    this.errorMessage = '',
  });
}

// Agenda Notifier to manage state
class AgendaNotifier extends StateNotifier<AgendaState> {
  AgendaNotifier() : super(AgendaState(agendas: []));

  // Fetch agendas from Hive database
  Future<void> fetchAgendas() async {
    state = AgendaState(agendas: [], isLoading: true);

    try {
      final agendaData = await AgendaServices().getAllAgendas();
      List<Agenda> fetchedAgendas = agendaData.map((e) => Agenda.fromModel(e)).toList();
      state = AgendaState(agendas: fetchedAgendas);
    } catch (e) {
      state = AgendaState(agendas: [], errorMessage: 'Failed to load agendas: $e');
    }
  }
}

// Riverpod provider
final agendaProvider = StateNotifierProvider<AgendaNotifier, AgendaState>((ref) {
  return AgendaNotifier();
});