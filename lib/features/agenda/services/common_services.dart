import 'package:agenda_management/features/agenda/view_model/agenda_state_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

bool canNavigateToPreviousWeek(AgendaState state) {
  DateTime previousWeekStart =
      state.currentWeekStart.subtract(Duration(days: 7));
  DateTime previousWeekEnd = previousWeekStart.add(Duration(days: 6));
  return !previousWeekEnd.isBefore(state.today);
}

String formatDate(DateTime date) {
  final month = DateFormat.MMM().format(date);
  return "${date.day}-$month-${date.year}";
}

List<DateTime> getWeekDates(DateTime weekStart) {
  return List.generate(7, (index) => weekStart.add(Duration(days: index)));
}

DateTime onlyTime(DateTime dateTime) {
  return DateTime(0, 1, 1, dateTime.hour, dateTime.minute, dateTime.second);
}

  DateTime dateTimeFromTimeOfDay(TimeOfDay timeOfDay, DateTime selectedDate) {
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
  }


  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
           date1.month == date2.month &&
           date1.day == date2.day;
  }