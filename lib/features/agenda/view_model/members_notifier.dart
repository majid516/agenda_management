import 'package:flutter_riverpod/flutter_riverpod.dart';

class Member {
  final String name;
  final String imageUrl;

  Member({required this.name, required this.imageUrl});
}

final membersProvider = Provider<List<Member>>((ref) => [
  Member(name: 'Henry', imageUrl: 'asset/65893b93c3ced7ffe1b8769e4ca89e87.jpg'),
  Member(name: 'Charlie', imageUrl: 'asset/15b0c5283d65f81adb69c09aac684554.jpg'),
  Member(name: 'David', imageUrl: 'asset/43a95ab96c6757ca3882df3dc03db1fd.jpg'),
  Member(name: 'Grace', imageUrl: 'asset/37978a9c8ed8d080880e543b3d9975c8-1.jpg'),
  Member(name: 'Bob', imageUrl: 'asset/8d9503a77e4c21ebf0ced6c252819a0e.jpg'),
  Member(name: 'Emma', imageUrl: 'asset/98a6aadc34b3519d5c4e0a6150f0701f.jpg'),
  Member(name: 'Frank', imageUrl: 'asset/902b26a614eb8f50aef6f4549b81cf2b.jpg'),
  Member(name: 'Isabella', imageUrl: 'asset/abc3da528d36a9a3f06e8682fd534c38.jpg'),
  Member(name: 'Mila', imageUrl: 'asset/e3ac809e119e8e96367c796451b8c968.jpg'),
  Member(name: 'Alice', imageUrl: 'asset/7fd65db99375e3a5b20c5e9225ba9bf9.jpg'),
  Member(name: 'Kelly', imageUrl: 'asset/cbc66b4baa36fc1af883a3b7f5655335.jpg'),
  Member(name: 'Liam', imageUrl: 'asset/d0cbd1380c72ddf3750c896433b2dea1.jpg'),
  Member(name: 'Noah', imageUrl: 'asset/fdc4dca4abca381306d1299be580c853.jpg'),
  Member(name: 'Olivia', imageUrl: 'asset/ff82867a5f89a41bc5c7c764caa9f398.jpg'),
  Member(name: 'Jack', imageUrl: 'asset/cb880d3fd081d1cc7b89b5370301c2c4.jpg'),
    ]);

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
