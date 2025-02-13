
import 'package:flutter/material.dart';

class AgendaState {
  final DateTime today;
  final DateTime selectedDate;
  final DateTime currentWeekStart;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String timeErrorMessage;

  AgendaState({
    required this.today,
    required this.selectedDate,
    required this.currentWeekStart,
    required this.startTime,
    required this.endTime,
    required this.timeErrorMessage,
  });

  AgendaState copyWith({
    DateTime? today,
    DateTime? selectedDate,
    DateTime? currentWeekStart,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? timeErrorMessage,
  }) {
    return AgendaState(
      today: today ?? this.today,
      selectedDate: selectedDate ?? this.selectedDate,
      currentWeekStart: currentWeekStart ?? this.currentWeekStart,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeErrorMessage: timeErrorMessage ?? this.timeErrorMessage,
    );
  }
}
