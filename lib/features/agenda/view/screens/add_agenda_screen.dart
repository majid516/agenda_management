import 'dart:developer';

import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:agenda_management/features/agenda/model/agenda_state_model.dart';
import 'package:agenda_management/features/agenda/services/agenda_services.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddAgendaScreen extends ConsumerWidget {
  const AddAgendaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendaState = ref.watch(agendaProvider);
    final agendaNotifier = ref.read(agendaProvider.notifier);

    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    List<DateTime> weekDates = _getWeekDates(agendaState.currentWeekStart);
    List<String> members = [];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyColors.whiteColor,
            size: 22,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: const Text(
            'Add Agendas',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: MyColors.whiteColor),
          ),
        ),
        backgroundColor: MyColors.primayColor,
        centerTitle: true,
      ),
      backgroundColor: MyColors.ternaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left, size: 32),
                  onPressed: _canNavigateToPreviousWeek(agendaState)
                      ? () {
                          agendaNotifier.updateWeekStart(agendaState
                              .currentWeekStart
                              .subtract(const Duration(days: 7)));
                        }
                      : null,
                ),
                Text(
                  _formatDate(agendaState.selectedDate),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right, size: 32),
                  onPressed: () {
                    agendaNotifier.updateWeekStart(agendaState.currentWeekStart
                        .add(const Duration(days: 7)));
                  },
                ),
              ],
            ),
            Row(
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
                        bool isDisabled = date.isBefore(agendaState.today);
                        bool isSelected =
                            date.year == agendaState.selectedDate.year &&
                                date.month == agendaState.selectedDate.month &&
                                date.day == agendaState.selectedDate.day;
                        return GestureDetector(
                          onTap: isDisabled
                              ? null
                              : () {
                                  agendaNotifier.selectDate(date);
                                },
                          child: Container(
                            width: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? MyColors.primayColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  _getWeekdayAbbreviation(date),
                                  style: TextStyle(
                                    color: isDisabled
                                        ? Colors.grey
                                        : (isSelected
                                            ? Colors.white
                                            : Colors.black),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${date.day}",
                                  style: TextStyle(
                                    color: isDisabled
                                        ? Colors.grey
                                        : (isSelected
                                            ? Colors.white
                                            : Colors.black),
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
            ),
            Row(
              children: [
                Expanded(
                    child: GestureDetector(
                  onTap: () async {
                    DateTime dateTimeFromTimeOfDay(TimeOfDay timeOfDay) {
                      final now = DateTime.now();
                      return DateTime(now.year, now.month, now.day,
                          timeOfDay.hour, timeOfDay.minute);
                    }

                    TimeOfDay? picked = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(
                          hour: agendaState.startTime.hour,
                          minute: agendaState.startTime.minute),
                    );
                    if (picked != null) {
                      
                      agendaNotifier
                          .updateStartTime(dateTimeFromTimeOfDay(picked));
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Start Time",
                        hintText: DateFormat('hh:mm a').format(agendaState
                            .startTime), // Format DateTime to 12-hour time (e.g., 5:30 PM)
                        border: const OutlineInputBorder(),
                      ),
                      controller: TextEditingController(
                        text: DateFormat('hh:mm a')
                            .format(agendaState.startTime), // Format DateTime
                      ),
                    ),
                  ),
                )),
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      DateTime dateTimeFromTimeOfDay(TimeOfDay timeOfDay) {
                        final now = DateTime.now();
                        return DateTime(now.year, now.month, now.day,
                            timeOfDay.hour, timeOfDay.minute);
                      }

                      TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: agendaState.endTime.hour,
                            minute: agendaState.endTime.minute,
                          ));
                      if (picked != null) {
                        agendaNotifier
                            .updateEndTime(dateTimeFromTimeOfDay(picked));
                      }
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "End Time",
                          hintText: DateFormat('hh:mm a').format(agendaState
                              .endTime), // Format DateTime to 12-hour time (e.g., 5:30 PM)
                          border: const OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                          text: DateFormat('hh:mm a')
                              .format(agendaState.endTime), // Format DateTime
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (agendaState.timeErrorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  agendaState.timeErrorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            CustomTextFormField(
              controller: descriptionController,
              maxLines: 1,
              hintText: 'Enter agenda Title',
              labelText: 'Title',
            ),
            CustomTextFormField(
              controller: titleController,
              maxLines: 3,
              hintText: 'Enter agenda description...',
              labelText: 'Description',
            ),
            ListTile(
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text("Presenters/Speakers"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 17,
              ),
              onTap: () async {
                members =
                    await Navigator.pushNamed(context, '/selectMembersScreen')
                        as List<String>;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomBigButton(
                  action: () async {
                    final customId = generateRandomNumber();
                    final agendaModel = AgendaModel(
                        id: customId.toString(),
                        date: DateFormat.yMd().format(agendaState.selectedDate),
                        startingTime:
                            DateFormat('hh:mm a').format(agendaState.startTime),
                        endingTime:
                            DateFormat('hh:mm a').format(agendaState.endTime),
                        title: titleController.text.toString(),
                        description: descriptionController.text.trim(),
                        members: members);
                    AgendaServices().addNewAgenda(agendaModel);
                    log(agendaModel.toString());
                    if (descriptionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter a description")),
                      );
                      return;
                    }
                    // if (_timeToDouble(endTime) < _timeToDouble(startTime)) {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //         content: Text(
                    //             "End Time cannot be earlier than Start Time")),
                    //   );
                    //   return;
                    // }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Agenda Saved")),
                    );
                  },
                  text: '+ Add Your Agenda',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper functions
  bool _canNavigateToPreviousWeek(AgendaState state) {
    DateTime previousWeekStart =
        state.currentWeekStart.subtract(Duration(days: 7));
    DateTime previousWeekEnd = previousWeekStart.add(Duration(days: 6));
    return !previousWeekEnd.isBefore(state.today);
  }

  String _formatDate(DateTime date) {
    return "${date.day}-${date.month}-${date.year}";
  }

  String _getWeekdayAbbreviation(DateTime date) {
    List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return weekdays[date.weekday % 7];
  }

  List<DateTime> _getWeekDates(DateTime weekStart) {
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }
}

class CustomBigButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  const CustomBigButton({
    super.key,
    required this.action,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: ScreenSize.width * 0.9,
        height: 40,
        decoration: BoxDecoration(
            color: MyColors.secondaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 18,
              color: MyColors.whiteColor,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final int maxLines;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.maxLines,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(),
      ),
    );
  }
}
