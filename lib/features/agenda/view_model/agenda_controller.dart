import 'package:agenda_management/features/agenda/model/agenda_state_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AgendaNotifier extends StateNotifier<AgendaState> {
  AgendaNotifier()
      : super(
          AgendaState(
            today: DateTime.now(),
            selectedDate: DateTime.now(),
            currentWeekStart: _getStartOfWeek(DateTime.now()),
            startTime: TimeOfDay.now(),
            endTime: _addMinutesToTimeOfDay(TimeOfDay.now(), 30),
            timeErrorMessage: '',
          ),
        );

  static DateTime _getStartOfWeek(DateTime date) {
    int subtractDays = date.weekday % 7;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: subtractDays));
  }

  static TimeOfDay _addMinutesToTimeOfDay(TimeOfDay time, int minutesToAdd) {
    int totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;
    return TimeOfDay(hour: newHour % 24, minute: newMinute);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void updateWeekStart(DateTime newWeekStart) {
    state = state.copyWith(currentWeekStart: newWeekStart);
  }

  void updateStartTime(TimeOfDay newStartTime) {
    state = state.copyWith(startTime: newStartTime);
  }

  void updateEndTime(TimeOfDay newEndTime) {
    if (_timeToDouble(newEndTime) < _timeToDouble(state.startTime)) {
      state = state.copyWith(timeErrorMessage: "End Time cannot be earlier than Start Time");
    } else {
      state = state.copyWith(timeErrorMessage: '', endTime: newEndTime);
    }
  }

  static double _timeToDouble(TimeOfDay tod) => tod.hour + tod.minute / 60.0;
}

final agendaProvider = StateNotifierProvider<AgendaNotifier, AgendaState>((ref) {
  return AgendaNotifier();
});
