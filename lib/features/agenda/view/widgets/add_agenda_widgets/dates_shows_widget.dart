import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
import 'package:flutter/material.dart';

class DatesShowsWidget extends StatelessWidget {
  const DatesShowsWidget({
    super.key,
    required this.weekDates,
    required this.agendaState,
    required this.agendaNotifier,
  });

  final List<DateTime> weekDates;
  final AgendaState agendaState;
  final AgendaNotifier agendaNotifier;

  @override
  Widget build(BuildContext context) {
    String getWeekdayAbbreviation(DateTime date) {
      List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
      return weekdays[date.weekday % 7];
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weekDates.length,
              itemBuilder: (context, index) {
                DateTime date = weekDates[index];
                bool isDisabled = date.isBefore(DateTime(agendaState.today.year,
                    agendaState.today.month, agendaState.today.day));

                bool isSelected = date.year == agendaState.selectedDate.year &&
                    date.month == agendaState.selectedDate.month &&
                    date.day == agendaState.selectedDate.day;
                return GestureDetector(
                  onTap: isDisabled
                      ? null
                      : () {
                          agendaNotifier.selectDate(date);
                        },
                  child: Container(
                    width: ScreenSize.width * 1 / 9,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? MyColors.primayColor : Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          getWeekdayAbbreviation(date),
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: isDisabled
                                ? Colors.grey
                                : (isSelected ? Colors.white : Colors.black),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${date.day}",
                          style: TextStyle(
                            color: isDisabled
                                ? Colors.grey
                                : (isSelected ? Colors.white : Colors.black),
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
