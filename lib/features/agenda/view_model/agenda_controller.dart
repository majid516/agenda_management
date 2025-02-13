import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:agenda_management/features/agenda/services/agenda_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
class AgendaNotifier extends StateNotifier<AgendaState> {
  AgendaNotifier()
      : super(
          AgendaState(
            today: DateTime.now(),
            selectedDate: DateTime.now(),
            currentWeekStart: _getStartOfWeek(DateTime.now()),
            startTime: DateTime.now(),
            endTime: _addMinutesToDateTime(DateTime.now(), 30),
            timeErrorMessage: '',
            agendas: [],
            isLoading: false,
            errorMessage: '',
          ),
        );

  static DateTime _getStartOfWeek(DateTime date) {
    int subtractDays = date.weekday % 7;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: subtractDays));
  }

  static DateTime _addMinutesToDateTime(DateTime time, int minutesToAdd) {
    return time.add(Duration(minutes: minutesToAdd));
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateWeekStart(DateTime newWeekStart) {
    state = state.copyWith(currentWeekStart: newWeekStart);
  }

  void updateStartTime(DateTime newStartTime) {
    state = state.copyWith(startTime: newStartTime);
  }

  void updateEndTime(DateTime newEndTime) {
    if (newEndTime.isBefore(state.startTime)) {
      state = state.copyWith(
        timeErrorMessage: "End Time cannot be earlier than Start Time",
      );
    } else {
      state = state.copyWith(
        timeErrorMessage: '',
        endTime: newEndTime,
      );
    }
  }

  Future<void> fetchAgendas() async {
    state = state.copyWith(isLoading: true);
    try {
      final agendaData = await AgendaServices().getAllAgendas();
      List<Agenda> fetchedAgendas =
          agendaData.map<Agenda>((e) => Agenda.fromModel(e)).toList();
      state = state.copyWith(agendas: fetchedAgendas, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        agendas: [],
        isLoading: false,
        errorMessage: 'Failed to load agendas: $e',
      );
    }
  }
}


final agendaProvider =
    StateNotifierProvider<AgendaNotifier, AgendaState>((ref) => AgendaNotifier());
