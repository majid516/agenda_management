import 'package:agenda_management/common/components/custom_snackbar.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
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

  DateTime dateTimeFromTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day, timeOfDay.hour, timeOfDay.minute);
  }

  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: agendaState.startTime.hour, minute: agendaState.startTime.minute),
  );

  if (picked != null) {
    DateTime pickedDateTime = dateTimeFromTimeOfDay(picked);

    // Check if the selected date is today
    bool isToday = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    if (isToday) {
      // If today, start time must be in the future
      if (pickedDateTime.isBefore(now)) {
        if (context.mounted) {
          showCustomSnackBar(context, 'Start time must be in the future.', true);
        }
        return;
      }
    }
onTap: () async {
  DateTime now = DateTime.now();
  DateTime selectedDate = agendaState.selectedDate;

  DateTime dateTimeFromTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day, timeOfDay.hour, timeOfDay.minute);
  }

  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: agendaState.startTime.hour, minute: agendaState.startTime.minute),
  );

  if (picked != null) {
    DateTime pickedDateTime = dateTimeFromTimeOfDay(picked);

    // Check if the selected date is today
    bool isToday = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    if (isToday) {
      // If today, start time must be in the future
      if (pickedDateTime.isBefore(now)) {
        if (context.mounted) {
          showCustomSnackBar(context, 'Start time must be in the future.', true);
        }
        return;
      }
    }

    // Always check that start time is before end time
    if (pickedDateTime.isAfter(agendaState.endTime)) {
      if (context.mounted) {
        showCustomSnackBar(context, 'Start time cannot be after the end time.', true);
      }
      return;
    }

    // Start time and end time cannot be the same
    if (pickedDateTime.isAtSameMomentAs(agendaState.endTime)) {
      if (context.mounted) {
        showCustomSnackBar(context, 'Start time and end time cannot be the same.', true);
      }
      return;
    }

    agendaNotifier.updateStartTime(pickedDateTime);
  }
};

  
    // Start time and end time cannot be the same
    if (pickedDateTime.isAtSameMomentAs(agendaState.endTime)) {
      if (context.mounted) {
        showCustomSnackBar(context, 'Start time and end time cannot be the same.', true);
      }
      return;
    }

    agendaNotifier.updateStartTime(pickedDateTime);
  }
}
,
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

  DateTime dateTimeFromTimeOfDay(TimeOfDay timeOfDay) {
    return DateTime(selectedDate.year, selectedDate.month, selectedDate.day, timeOfDay.hour, timeOfDay.minute);
  }

  TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: agendaState.endTime.hour, minute: agendaState.endTime.minute),
  );

  if (picked != null) {
    DateTime pickedDateTime = dateTimeFromTimeOfDay(picked);

    // Check if the selected date is today
    bool isToday = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;

    if (isToday) {
      // If today, end time must be in the future
      if (pickedDateTime.isBefore(now)) {
        if (context.mounted) {
          showCustomSnackBar(context, 'End time must be in the future.', true);
        }
        return;
      }
    }

    // End time must be after the start time
    if (pickedDateTime.isBefore(agendaState.startTime)) {
      if (context.mounted) {
        showCustomSnackBar(context, 'End time must be after the start time.', true);
      }
      return;
    }

    // Start time and end time cannot be the same
    if (pickedDateTime.isAtSameMomentAs(agendaState.startTime)) {
      if (context.mounted) {
        showCustomSnackBar(context, 'Start time and end time cannot be the same.', true);
      }
      return;
    }

    agendaNotifier.updateEndTime(pickedDateTime);
  }
}


,

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
