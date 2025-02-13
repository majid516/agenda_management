// providers/members_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final membersProvider = Provider<List<String>>((ref) => [
  'Alice', 'Bob', 'Charlie', 'David', 'Emma', 'Frank'
]);

final selectedMembersProvider = StateNotifierProvider<SelectedMembersNotifier, List<String>>(
  (ref) => SelectedMembersNotifier(),
);

class SelectedMembersNotifier extends StateNotifier<List<String>> {
  SelectedMembersNotifier() : super([]);

  void toggleSelection(String member) {
    state = state.contains(member)
        ? state.where((m) => m != member).toList()
        : [...state, member];
  }
}
