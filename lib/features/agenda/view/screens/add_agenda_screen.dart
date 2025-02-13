import 'package:agenda_management/common/components/custom_snackbar.dart';
import 'package:agenda_management/common/components/sizes.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:agenda_management/features/agenda/services/agenda_services.dart';
import 'package:agenda_management/features/agenda/services/common_services.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_agenda_widgets/custom_text_form_field.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_agenda_widgets/dates_shows_widget.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_agenda_widgets/time_selection_raw_widget.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/common_app_bar.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/custom_big_button.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
import 'package:agenda_management/features/agenda/view_model/members_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddAgendaScreen extends ConsumerStatefulWidget {
  const AddAgendaScreen({super.key});
  @override
  ConsumerState<AddAgendaScreen> createState() => _AgendaHomeScreenState();
}

class _AgendaHomeScreenState extends ConsumerState<AddAgendaScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final agendaState = ref.watch(agendaProvider);
    final agendaNotifier = ref.read(agendaProvider.notifier);
    final selectedMembers = ref.watch(selectedMembersProvider);
    List<DateTime> weekDates = getWeekDates(agendaState.currentWeekStart);
    List<String> members = [];
    final selectedImages =
        selectedMembers.map((member) => member.imageUrl).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: CommonAppBar(
          title: 'Add Agendas',
        ),
      ),
      backgroundColor: MyColors.ternaryColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_left, size: 32),
                  onPressed: canNavigateToPreviousWeek(agendaState)
                      ? () {
                          agendaNotifier.updateWeekStart(
                            agendaState.currentWeekStart
                                .subtract(const Duration(days: 7)),
                          );
                        }
                      : null,
                ),
                Text(
                  formatDate(agendaState.selectedDate),
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_right, size: 32),
                  onPressed: () {
                    agendaNotifier.updateWeekStart(
                      agendaState.currentWeekStart.add(const Duration(days: 7)),
                    );
                  },
                ),
              ],
            ),
           
            CustomBigButton(
              action: () async {
                if (titleController.text.isEmpty) {
                  showCustomSnackBar(context, 'Please fill in the title', true);
                } else if (descriptionController.text.isEmpty) {
                  showCustomSnackBar(
                      context, 'Please fill in the description', true);
                } else if (selectedMembers.isEmpty) {
                  showCustomSnackBar(context, 'Please select members', true);
                } else if (agendaState.startTime
                    .isBefore(agendaState.endTime)) {
                  showCustomSnackBar(
                      context, 'Start time must be before end time', true);
                } else if (agendaState.startTime
                    .isAtSameMomentAs(agendaState.endTime)) {
                  showCustomSnackBar(context,
                      'Start time and end time cannot be the same', true);
                } else {
                  final customId = generateRandomNumber();
                  final agendaModel = AgendaModel(
                    id: customId.toString(),
                    date: DateFormat.yMd().format(agendaState.selectedDate),
                    startingTime:
                        DateFormat('hh:mm a').format(agendaState.startTime),
                    endingTime:
                        DateFormat('hh:mm a').format(agendaState.endTime),
                    title: titleController.text,
                    description: descriptionController.text.trim(),
                    members: selectedImages,
                  );

                  await AgendaServices().addNewAgenda(agendaModel);
                  await ref.read(agendaProvider.notifier).fetchAgendas();
                  ref.read(selectedMembersProvider.notifier).clearList();

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              text: 'Add Your Agenda',
            ),
          ],
        ),
      ),
    );
  }
}



class AddScreenElementsColumn extends ConsumerWidget {
  const AddScreenElementsColumn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendaState = ref.watch(agendaProvider);
    final agendaNotifier = ref.read(agendaProvider.notifier);
    final selectedMembers = ref.watch(selectedMembersProvider);
    List<DateTime> weekDates = getWeekDates(agendaState.currentWeekStart);
    final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
    return Column(
      children: [
         Spaces.height10,
            DatesShowsWidget(
              weekDates: weekDates,
              agendaState: agendaState,
              agendaNotifier: agendaNotifier,
            ),
            Spaces.height25,
            TimeSelectionRawWidget(
              agendaState: agendaState,
              agendaNotifier: agendaNotifier,
            ),
            if (agendaState.timeErrorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  agendaState.timeErrorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            Spaces.height10,
            CustomTextFormField(
              controller: titleController,
              maxLines: 1,
              hintText: 'Enter agenda Title',
              labelText: 'Title',
            ),
            Spaces.height10,
            CustomTextFormField(
              controller: descriptionController,
              maxLines: 3,
              hintText: 'Enter agenda description...',
              labelText: 'Description',
            ),
            Spaces.height15,
            ListTile(
              tileColor: Colors.grey.shade200,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              title: selectedMembers.isEmpty
                  ? const Text("Presenters/Speakers")
                  : Text("${selectedMembers.length} Members Selected"),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 17,
              ),
              onTap: () async {
                List<String>? data =
                    await Navigator.pushNamed(context, '/selectMembersScreen')
                        as List<String>?;
                members = data ?? [];
              },
            ),
            Spaces.height25,
      ],
    );
  }
}