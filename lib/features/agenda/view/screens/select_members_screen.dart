import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/screens/add_agenda_screen.dart';
import 'package:agenda_management/features/agenda/view_model/members_notifier.dart';
import 'package:flutter/material.dart';
// screens/select_members_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectMembersScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(membersProvider);
    final selectedMembers = ref.watch(selectedMembersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new, size: 22),
        ),
        title: Text('Select Members', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, __) => Divider(),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                final isSelected = selectedMembers.contains(member);

                return ListTile(
                  leading: CircleAvatar(child: Text(member[0], style: TextStyle(fontSize: 20))),
                  title: Text(member),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: Colors.blue)
                      : Icon(Icons.circle_outlined, color: Colors.grey),
                  onTap: () => ref.read(selectedMembersProvider.notifier).toggleSelection(member),
                );
              },
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, selectedMembers),
            child: Text('Add Selected Members'),
          ),
        ],
      ),
    );
  }
}
