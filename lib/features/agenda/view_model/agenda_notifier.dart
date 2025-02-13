import 'package:agenda_management/features/agenda/services/agenda_services.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final agendaProvider = StateNotifierProvider<AgendaNotifier, AgendaState>(
    (ref) => AgendaNotifier());
