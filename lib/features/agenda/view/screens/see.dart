import 'dart:math';

import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// // class AgendaItem {
// //   final String title;
// //   final String description;
// //   final DateTime startTime;
// //   final DateTime endTime;
// //   final List<String> members;

// //   AgendaItem(this.members, {
// //     required this.title,
// //     required this.description,
// //     required this.startTime,
// //     required this.endTime,
// //   });
// // }

// class AgendaList extends StatelessWidget {
//   const AgendaList({super.key});

//   @override
//   Widget build(BuildContext context) {
//    // List<AgendaItem> agendaItems = [
//       // AgendaItem(
//       //   title: "Opening Ceremony",
//       //   description: "Welcome speech and introductions.",
//       //   startTime: DateTime.now().subtract(const Duration(hours: 0)),
//       //   endTime: DateTime.now().subtract(const Duration(hours: 0)),
//       // ),
//       // AgendaItem(
//       //   title: "Keynote Speech",
//       //   description: "Main address by the keynote speaker.",
//       //   startTime: DateTime.now().subtract(const Duration(minutes: 0)),
//       //   endTime: DateTime.now().add(const Duration(minutes: 2)),
//       // ),
//       // AgendaItem(
//       //   title: "Networking Session",
//       //   description: "Meet and interact with peers.",
//       //   startTime: DateTime.now().add(const Duration(hours: 10)),
//       //   endTime: DateTime.now().add(const Duration(hours: 2)),
//       // ),
//       // AgendaItem(
//       //   title: "Networking Session",
//       //   description: "Meet and interact with peers.",
//       //   startTime: DateTime.now().add(const Duration(hours: 1)),
//       //   endTime: DateTime.now().add(const Duration(hours: 2)),
//       // ),
//     ];

//     return ListView.builder(
//       padding: const EdgeInsets.all(12.0),
//       itemCount: agendaItems.length,
//       itemBuilder: (context, index) {
//         return AgendaCard(agendaItem: agendaItems[index], isLast: index == agendaItems.length - 1);
//       },
//     );
//   }
// }

class AgendaCard extends StatelessWidget {
  final Agenda agendaItem;
  final bool isLast;

  const AgendaCard({super.key, required this.agendaItem, required this.isLast});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    Color statusColor;
    Widget circle;
    DateTime startTime = DateFormat('hh:mm a').parse(agendaItem.startTime);
    DateTime endTime = DateFormat('hh:mm a').parse(agendaItem.endTime);

    if (endTime.isBefore(now)) {
      statusColor = Colors.blue;
      circle = const Icon(Icons.circle, color: Colors.blue, size: 13);
    } else if (startTime.isBefore(now) && endTime.isAfter(now)) {
      statusColor = Colors.blue;
      circle = const Icon(Icons.circle_outlined, color: Colors.blue, size: 13);
    } else {
      statusColor = Colors.grey;
      circle = const Icon(Icons.circle_outlined, color: Colors.grey, size: 13);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            circle,
            Container(height: 50, width: 2, color: statusColor),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Card(
            margin: EdgeInsets.all(2),
            elevation: 2,
            color: MyColors.primayColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(agendaItem.time,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: MyColors.whiteColor)),
                      MemberStack(
                        members: agendaItem.members,
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    agendaItem.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: MyColors.whiteColor),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'agendaItem.description',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 204, 204, 204)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String formatTimeOfDay(String timeOfDay) {
  // Split "00:08" into hours and minutes
  List<String> parts = timeOfDay.split(':');
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  // Convert to 12-hour format
  String period = hour < 12 ? 'AM' : 'PM';
  int formattedHour = (hour == 0) ? 12 : (hour > 12 ? hour - 12 : hour);
  String formattedMinute = minute.toString().padLeft(2, '0');

  return '$formattedHour:$formattedMinute $period';
}

class MemberStack extends StatelessWidget {
  final List<String> members;

  const MemberStack({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double avatarSize = 22;
    const double overlapOffset = 12;

    // Calculate the number of widgets to display.
    final int displayCount = min(members.length, 3);

    // Calculate the total width.
    // For each avatar except the first, we only add the overlapOffset.
    // Then add the width of the avatar.
    double stackWidth = (displayCount - 1) * overlapOffset + avatarSize;

    // If there are more than 3 members, add space for the extra indicator.
    if (members.length > 3) {
      stackWidth += overlapOffset;
    }

    return Container(
      width: stackWidth,
      height: avatarSize,
      // Using Clip.none in case any child is allowed to paint outside the container.
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left: i * overlapOffset,
              child: PositionedAvatar(
                name: members[i],
                index: i,
              ),
            ),
          if (members.length > 3)
            Positioned(
              left: displayCount * overlapOffset,
              child: CircleAvatar(
                radius: 11,
                backgroundColor: MyColors.whiteColor,
                child: Text(
                  '+${members.length - 3}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class PositionedAvatar extends StatelessWidget {
  final String name;
  final int index;

  const PositionedAvatar({Key? key, required this.name, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          name[0],
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
