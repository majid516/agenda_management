import 'package:agenda_management/common/components/custom_snackbar.dart';
import 'package:agenda_management/features/agenda/services/common_services.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_notifier.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_state_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSelectionRawWidget extends StatelessWidget {
  const TimeSelectionRawWidget({
    super.key,
    required this.agendaState,
    required this.agendaNotifier,
  });

  final AgendaState agendaState;
  final AgendaNotifier agendaNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              DateTime now = DateTime.now();
              DateTime selectedDate = agendaState.selectedDate;
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: agendaState.startTime.hour,
                  minute: agendaState.startTime.minute,
                ),
              );
              if (picked != null) {
                DateTime pickedDateTime =
                    dateTimeFromTimeOfDay(picked, selectedDate);
                bool isToday = isSameDay(selectedDate, now);
                if (isToday && pickedDateTime.isBefore(now)) {
                  if (context.mounted) {
                    showCustomSnackBar(
                        context, 'Start time must be in the future.', true);
                  }
                  return;
                }
                if (onlyTime(pickedDateTime)
                    .isAfter(onlyTime(agendaState.endTime))) {
                  if (context.mounted) {
                    showCustomSnackBar(
                        context, 'Start time must be before end time.', true);
                  }
                  return;
                }
                if (onlyTime(pickedDateTime)
                    .isAtSameMomentAs(onlyTime(agendaState.endTime))) {
                  if (context.mounted) {
                    showCustomSnackBar(context,
                        'Start time and end time cannot be the same.', true);
                  }
                  return;
                }
                agendaNotifier.updateStartTime(pickedDateTime);
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Start Time",
                  hintText: DateFormat('hh:mm a').format(agendaState.startTime),
                  border: const OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: DateFormat('hh:mm a').format(agendaState.startTime),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: GestureDetector(
            onTap: () async {
              DateTime now = DateTime.now();
              DateTime selectedDate = agendaState.selectedDate;
              TimeOfDay? picked = await showTimePicker(
                context: context,
                initialTime: TimeOfDay(
                  hour: agendaState.endTime.hour,
                  minute: agendaState.endTime.minute,
                ),
              );
              if (picked != null) {
                DateTime pickedDateTime =
                    dateTimeFromTimeOfDay(picked, selectedDate);
                bool isToday = isSameDay(selectedDate, now);
                if (isToday && pickedDateTime.isBefore(now)) {
                  if (context.mounted) {
                    showCustomSnackBar(
                        context, 'End time must be in the future.', true);
                  }
                  return;
                }
                if (onlyTime(pickedDateTime)
                    .isBefore(onlyTime(agendaState.startTime))) {
                  if (context.mounted) {
                    showCustomSnackBar(
                        context, 'End time must be after start time.', true);
                  }
                  return;
                }
                if (onlyTime(pickedDateTime)
                    .isAtSameMomentAs(onlyTime(agendaState.startTime))) {
                  if (context.mounted) {
                    showCustomSnackBar(context,
                        'Start time and end time cannot be the same.', true);
                  }
                  return;
                }
                agendaNotifier.updateEndTime(pickedDateTime);
              }
            },
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "End Time",
                  hintText: DateFormat('hh:mm a').format(agendaState.endTime),
                  border: const OutlineInputBorder(),
                ),
                controller: TextEditingController(
                  text: DateFormat('hh:mm a').format(agendaState.endTime),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
