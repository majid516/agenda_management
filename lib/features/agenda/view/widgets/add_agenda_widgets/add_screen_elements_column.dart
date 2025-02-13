import 'package:agenda_management/common/components/sizes.dart';
import 'package:agenda_management/features/agenda/services/common_services.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_agenda_widgets/custom_text_form_field.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_agenda_widgets/dates_shows_widget.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_agenda_widgets/time_selection_raw_widget.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_notifier.dart';
import 'package:agenda_management/features/agenda/view_model/members_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddScreenElementsColumn extends ConsumerWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final List<String> members;  

  const AddScreenElementsColumn(
    this.titleController,
    this.descriptionController,
    this.members,  
    {super.key}
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendaState = ref.watch(agendaProvider);
    final agendaNotifier = ref.read(agendaProvider.notifier);
    final selectedMembers = ref.watch(selectedMembersProvider);
    List<DateTime> weekDates = getWeekDates(agendaState.currentWeekStart);

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
            if (data != null) {
              members.clear();
              members.addAll(data); 
            }
          },
        ),
        Spaces.height25,
      ],
    );
  }
}
