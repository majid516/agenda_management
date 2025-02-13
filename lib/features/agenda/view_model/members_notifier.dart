import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a member model
class Member {
  final String name;
  final String imageUrl;

  Member({required this.name, required this.imageUrl});
}

// Members list with names and image URLs
final membersProvider = Provider<List<Member>>((ref) => [
  Member(name: 'Alice', imageUrl: 'https://randomuser.me/api/portraits/women/1.jpg'),
  Member(name: 'Bob', imageUrl: 'https://randomuser.me/api/portraits/men/2.jpg'),
  Member(name: 'Charlie', imageUrl: 'https://randomuser.me/api/portraits/men/3.jpg'),
  Member(name: 'David', imageUrl: 'https://randomuser.me/api/portraits/men/4.jpg'),
  Member(name: 'Emma', imageUrl: 'https://randomuser.me/api/portraits/women/2.jpg'),
  Member(name: 'Frank', imageUrl: 'https://randomuser.me/api/portraits/men/5.jpg'),
  Member(name: 'Grace', imageUrl: 'https://randomuser.me/api/portraits/women/3.jpg'),
  Member(name: 'Henry', imageUrl: 'https://randomuser.me/api/portraits/men/6.jpg'),
  Member(name: 'Isabella', imageUrl: 'https://randomuser.me/api/portraits/women/4.jpg'),
  Member(name: 'Jack', imageUrl: 'https://randomuser.me/api/portraits/men/7.jpg'),
  Member(name: 'Kelly', imageUrl: 'https://randomuser.me/api/portraits/women/5.jpg'),
  Member(name: 'Liam', imageUrl: 'https://randomuser.me/api/portraits/men/8.jpg'),
  Member(name: 'Mia', imageUrl: 'https://randomuser.me/api/portraits/women/6.jpg'),
  Member(name: 'Noah', imageUrl: 'https://randomuser.me/api/portraits/men/9.jpg'),
  Member(name: 'Olivia', imageUrl: 'https://randomuser.me/api/portraits/women/7.jpg'),
  Member(name: 'Paul', imageUrl: 'https://randomuser.me/api/portraits/men/10.jpg'),
  Member(name: 'Quinn', imageUrl: 'https://randomuser.me/api/portraits/women/8.jpg'),
  Member(name: 'Ryan', imageUrl: 'https://randomuser.me/api/portraits/men/11.jpg'),
  Member(name: 'Sophia', imageUrl: 'https://randomuser.me/api/portraits/women/9.jpg'),
  Member(name: 'Tom', imageUrl: 'https://randomuser.me/api/portraits/men/12.jpg'),
    ]);

// Selected members provider
final selectedMembersProvider = StateNotifierProvider<SelectedMembersNotifier, List<Member>>(
  (ref) => SelectedMembersNotifier(),
);

class SelectedMembersNotifier extends StateNotifier<List<Member>> {
  SelectedMembersNotifier() : super([]);

  void toggleSelection(Member member) {
    state = state.contains(member)
        ? state.where((m) => m != member).toList()
        : [...state, member];
  }

  void clearList() {
    state.clear();
  }
}
