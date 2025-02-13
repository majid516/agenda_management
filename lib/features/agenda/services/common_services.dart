import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
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
