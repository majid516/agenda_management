import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:intl/intl.dart';

class Agenda {
  final DateTime date;
  final String title;
  final String time;
  final String startTime;
  final String endTime;
  final String description;
  final List<String> members;

  Agenda({
    required this.date,
    required this.title,
    required this.time,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.members,
  });

  factory Agenda.fromModel(AgendaModel model) {
    return Agenda(
      date: DateFormat('MM/dd/yyyy').parse(model.date),
      title: model.title,
      time: "${model.startingTime} - ${model.endingTime}",
      startTime: model.startingTime,
      endTime: model.endingTime,
      description: model.description,
      members: List<String>.from(model.members),
    );
  }
}

class AgendaState {
  final DateTime today;
  final DateTime selectedDate;
  final DateTime currentWeekStart;
  final DateTime startTime;
  final DateTime endTime;
  final String timeErrorMessage;
  final List<Agenda> agendas;
  final bool isLoading;
  final String errorMessage;

  AgendaState({
    required this.today,
    required this.selectedDate,
    required this.currentWeekStart,
    required this.startTime,
    required this.endTime,
    required this.timeErrorMessage,
    required this.agendas,
    required this.isLoading,
    required this.errorMessage,
  });

  AgendaState copyWith({
    DateTime? today,
    DateTime? selectedDate,
    DateTime? currentWeekStart,
    DateTime? startTime,
    DateTime? endTime,
    String? timeErrorMessage,
    List<Agenda>? agendas,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AgendaState(
      today: today ?? this.today,
      selectedDate: selectedDate ?? this.selectedDate,
      currentWeekStart: currentWeekStart ?? this.currentWeekStart,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeErrorMessage: timeErrorMessage ?? this.timeErrorMessage,
      agendas: agendas ?? this.agendas,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}