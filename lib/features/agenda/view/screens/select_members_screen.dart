import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/widgets/select_members_widgets/members_list_widget.dart';
import 'package:agenda_management/features/agenda/view/widgets/select_members_widgets/select_members_screen_elements_widget.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/common_app_bar.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/custom_big_button.dart';
import 'package:agenda_management/features/agenda/view_model/members_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectMembersScreen extends ConsumerWidget {
  const SelectMembersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersProvider);
    final selectedMembers = ref.watch(selectedMembersProvider);

    final selectedImages =
        selectedMembers.map((member) => member.imageUrl).toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: CommonAppBar(title: 'Select Members'),
      ),
      backgroundColor: MyColors.ternaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              if (selectedMembers.isNotEmpty)
                SelectMembersScreenElementsWidget(
                    selectedImages: selectedImages),
              if (selectedMembers.isNotEmpty)
                Divider(
                  height: 10,
                ),
              MembersListWidget(
                  members: members, selectedMembers: selectedMembers),
            ],
          ),
          Positioned(
            bottom: 40,
            child: CustomBigButton(
              action: () => Navigator.pop(context, selectedImages),
              text: 'Add Selected Members',
            ),
          ),
        ],
      ),
    );
  }
}
