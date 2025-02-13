import 'package:agenda_management/common/components/custom_snackbar.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/model/agenda_model.dart';
import 'package:agenda_management/features/agenda/services/agenda_services.dart';
import 'package:agenda_management/features/agenda/services/common_services.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_agenda_widgets/add_screen_elements_column.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/common_app_bar.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/custom_big_button.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_notifier.dart';
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

    List<String> members =
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
            AddScreenElementsColumn(
              titleController,
              descriptionController,
              members,
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
                } else if (onlyTime(agendaState.startTime)
                    .isAfter(onlyTime(agendaState.endTime))) {
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
                    members: members, // ✅ Use the members list here
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
