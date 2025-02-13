import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/widgets/home_widgets/member_stack.dart';
import 'package:agenda_management/features/agenda/view_model/agenda_controller.dart';
import 'package:flutter/material.dart';

class AgendaListTileElements extends StatelessWidget {
  const AgendaListTileElements({
    super.key,
    required this.circle,
    required this.statusColor,
    required this.agendaItem,
  });

  final Widget circle;
  final Color statusColor;
  final Agenda agendaItem;

  @override
  Widget build(BuildContext context) {
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
                    agendaItem.description,
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
