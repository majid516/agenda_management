import 'dart:developer';

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
            startTime: DateTime.now(),
            endTime: _addMinutesToDateTime(DateTime.now(), 30),
            timeErrorMessage: '',
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

  // static DateTime _getFormattedDateTime(DateTime dateTime) {
  //   return DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 24); // 12:24 AM format
  // }

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
      state = state.copyWith(timeErrorMessage: "End Time cannot be earlier than Start Time");
    } else {
      state = state.copyWith(timeErrorMessage: '', endTime:newEndTime);
    }
  }
}

final agendaProvider = StateNotifierProvider<AgendaNotifier, AgendaState>((ref) {
  return AgendaNotifier();
});
