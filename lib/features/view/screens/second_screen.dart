import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/view/screens/third_screen.dart';
import 'package:flutter/material.dart';


class AddAgendaScreen extends StatefulWidget {
  @override
  _AddAgendaScreenState createState() => _AddAgendaScreenState();
}

class _AddAgendaScreenState extends State<AddAgendaScreen> {
  DateTime today = DateTime.now();
  late DateTime selectedDate;
  late DateTime currentWeekStart; // Sunday of the currently viewed week

  // Time pickers’ initial values
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  // Controller for the description field.
  final TextEditingController descriptionController = TextEditingController();

  // Error message for time validation.
  String timeErrorMessage = '';

  @override
  void initState() {
    super.initState();
    // Initialize with today’s date (without time)
    today = DateTime.now();
    selectedDate = DateTime(today.year, today.month, today.day);
    currentWeekStart = _getStartOfWeek(selectedDate);
    startTime = TimeOfDay.now();
    // Set endTime to 30 minutes later by default.
    endTime = _addMinutesToTimeOfDay(startTime, 30);
  }

  /// Returns the Sunday of the week that contains [date].
  DateTime _getStartOfWeek(DateTime date) {
    // In Dart, Monday is 1 and Sunday is 7.
    // To get Sunday, subtract (date.weekday % 7) days.
    int subtractDays = date.weekday % 7;
    return DateTime(date.year, date.month, date.day)
        .subtract(Duration(days: subtractDays));
  }

  /// Generates a list of 7 dates starting from [weekStart] (assumed Sunday).
  List<DateTime> _getWeekDates(DateTime weekStart) {
    return List.generate(7, (index) => weekStart.add(Duration(days: index)));
  }

  /// Determines whether navigating to the previous week is allowed.
  bool _canNavigateToPreviousWeek() {
    DateTime previousWeekStart = currentWeekStart.subtract(Duration(days: 7));
    DateTime previousWeekEnd = previousWeekStart.add(Duration(days: 6));
    // Disallow if the entire previous week is before today.
    return !previousWeekEnd.isBefore(today);
  }

  /// Opens the time picker for the start time.
  Future<void> _selectStartTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: startTime,
      builder: (context, child) {
        return Theme(data: Theme.of(context), child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        startTime = picked;
        // Auto-adjust the end time if needed.
        if (_timeToDouble(endTime) < _timeToDouble(startTime)) {
          endTime = _addMinutesToTimeOfDay(startTime, 30);
        }
        timeErrorMessage = '';
      });
    }
  }

  /// Opens the time picker for the end time.
  Future<void> _selectEndTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: endTime,
      builder: (context, child) {
        return Theme(data: Theme.of(context), child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        if (_timeToDouble(picked) < _timeToDouble(startTime)) {
          // If an invalid time is picked, show an inline error message.
          timeErrorMessage = "End Time cannot be earlier than Start Time";
        } else {
          timeErrorMessage = '';
          endTime = picked;
        }
      });
    }
  }

  /// Converts a [TimeOfDay] to a double representing hours.
  double _timeToDouble(TimeOfDay tod) => tod.hour + tod.minute / 60.0;

  /// Adds [minutesToAdd] minutes to a given [TimeOfDay] and returns the new time.
  TimeOfDay _addMinutesToTimeOfDay(TimeOfDay time, int minutesToAdd) {
    int totalMinutes = time.hour * 60 + time.minute + minutesToAdd;
    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;
    // Adjust if hours go past midnight (you can customize this behavior)
    newHour = newHour % 24;
    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  @override
  Widget build(BuildContext context) {
    // Prepare the list of dates for the current week view.
    List<DateTime> weekDates = _getWeekDates(currentWeekStart);

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
            // Selected date display.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 IconButton(
                icon: const Icon(Icons.arrow_left, size: 32),
                onPressed: _canNavigateToPreviousWeek()
                    ? () {
                        setState(() {
                          currentWeekStart = currentWeekStart
                              .subtract(const Duration(days: 7));
                        });
                      }
                    : null,
              ),
                Text(
                  _formatDate(selectedDate),
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                 IconButton(
                icon: const Icon(Icons.arrow_right, size: 32),
                onPressed: () {
                  setState(() {
                    currentWeekStart =
                        currentWeekStart.add(const Duration(days: 7));
                  });
                },
              ),
              ],
            ),
            const SizedBox(height: 16),
            // Calendar Week View with navigation arrows.
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
                        // Dates before today are disabled.
                        bool isDisabled = date.isBefore(today);
                        bool isSelected = date.year == selectedDate.year &&
                            date.month == selectedDate.month &&
                            date.day == selectedDate.day;
                        return GestureDetector(
                          onTap: isDisabled
                              ? null
                              : () {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                },
                          child: Container(
                            width: 50,
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
                                const SizedBox(height: 4),
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
            const SizedBox(height: 25),
            // Time pickers for Start and End Time.
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _selectStartTime,
                    // AbsorbPointer prevents manual editing while still displaying text.
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Start Time",
                          hintText: startTime.format(context),
                          border: const OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: startTime.format(context)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: _selectEndTime,
                    child: AbsorbPointer(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "End Time",
                          hintText: endTime.format(context),
                          border: const OutlineInputBorder(),
                        ),
                        controller: TextEditingController(
                            text: endTime.format(context)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Display a validation error message if needed.
            if (timeErrorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  timeErrorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 16),
            // Description Text Field.
            TextFormField(
              controller: descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                hintText: "Enter agenda description...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // Presenters/Speakers selector row.
            ListTile(
              tileColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: const Text("Presenters/Speakers"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 17,),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SelectMembersScreen()),
                );
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (descriptionController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Please enter a description")),
                      );
                      return;
                    }
                    if (_timeToDouble(endTime) < _timeToDouble(startTime)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "End Time cannot be earlier than Start Time")),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Agenda Saved")),
                    );
                  },
                  child: Container(
                    width: ScreenSize.width * 0.9,
                    height: 40,
                    decoration: BoxDecoration(
                        color: MyColors.secondaryColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text(
                      '+ add your agenda',
                      style: TextStyle(
                        fontSize: 18,
                          color: MyColors.whiteColor,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day} ${_monthAbbreviation(date.month)}";
  }

  String _monthAbbreviation(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  String _getWeekdayAbbreviation(DateTime date) {
    const weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return weekdays[date.weekday % 7];
  }
}
