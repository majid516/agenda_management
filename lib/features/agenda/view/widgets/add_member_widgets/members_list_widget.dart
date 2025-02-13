import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view_model/members_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class MembersListWidget extends ConsumerWidget {
  final List<Member> members;
  final List<Member> selectedMembers;

  const MembersListWidget({super.key, required this.members, required this.selectedMembers});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) => Divider(height: 5,),
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          final isSelected = selectedMembers.contains(member);

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(member.imageUrl),
            ),
            title: Text(member.name),
            trailing: isSelected ? Icon(Icons.check_circle, color: MyColors.primayColor) : Icon(Icons.circle_outlined,color: MyColors.primayColor,),
            onTap: () {
              ref.read(selectedMembersProvider.notifier).toggleSelection(member);
            },
          );
        },
      ),
    );
  }
}
