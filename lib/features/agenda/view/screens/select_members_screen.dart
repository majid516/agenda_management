import 'package:agenda_management/common/components/sizes.dart';
import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/widgets/add_member_widgets/members_list_widget.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/common_app_bar.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/custom_big_button.dart';
import 'package:agenda_management/features/agenda/view/widgets/home_widgets/member_stack.dart';
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: SizedBox(
                    width: ScreenSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Members',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: MyColors.primayColor,
                          ),
                        ),
                        Spaces.height10,
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              MemberStack(
                                members: selectedImages,
                                avatarSize: 40,
                                showFullImage: true,
                                overlapOffset: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
