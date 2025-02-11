import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/view/screens/see.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  final List<Map<String, dynamic>> agendas = [
    {
      'date': DateTime(2024, 7, 1),
      'title': 'Opening Ceremony',
      'time': '09:00 AM',
      'members': ['A', 'B', 'C', 'D']
    },
    {
      'date': DateTime(2024, 7, 1),
      'title': 'Introduction Session',
      'time': '10:00 AM',
      'members': ['A', 'B', 'C', 'D']
    },
    {
      'date': DateTime(2024, 7, 5),
      'title': 'Tech Talk',
      'time': '02:00 PM',
      'members': ['E', 'F', 'G']
    },
    {
      'date': DateTime(2024, 7, 6),
      'title': 'Closing Remarks',
      'time': '05:00 PM',
      'members': ['H', 'I']
    },
    {
      'date': DateTime(2024, 7, 3),
      'title': 'Networking Session',
      'time': '11:00 AM',
      'members': ['J', 'K', 'L', 'M']
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Sort agendas by date.
    agendas.sort((a, b) => a['date'].compareTo(b['date']));

    // Group agendas by formatted date (e.g., "1 Jul").
    Map<String, List<Map<String, dynamic>>> groupedAgendas = {};
    for (var agenda in agendas) {
      String formattedDate = DateFormat('d MMM').format(agenda['date']);
      if (!groupedAgendas.containsKey(formattedDate)) {
        groupedAgendas[formattedDate] = [];
      }
      groupedAgendas[formattedDate]!.add(agenda);
    }

    // Create a list of dates (formatted) for tab creation.
    List<String> dates = groupedAgendas.keys.toList();

    return DefaultTabController(
      length: dates.length,
      child: Scaffold(
        // AppBar with gradient background.
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Agendas',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: MyColors.whiteColor),
                ),
                GestureDetector(
                  onTap: ()=> Navigator.of(context).pushNamed('/addTaskScreen'),
                  child: Container(padding: EdgeInsets.symmetric(horizontal: 10), height: 30, decoration: BoxDecoration( color: MyColors.secondaryColor,
                  borderRadius: BorderRadius.circular(8)
                  ),
                  child: Center(child: Text('+ add', style: TextStyle(fontSize: 17 ,color: MyColors.whiteColor, fontWeight: FontWeight.bold),)),
                  ),
                )
              ],
            ),
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [MyColors.primayColor, MyColors.primayColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: MyColors.primayColor,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: TabBar(
                dividerHeight: 0,
                indicatorPadding:
                    EdgeInsets.symmetric(vertical: 7, horizontal: -7),

                isScrollable: true,
                // Custom pill-shaped indicator.
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: MyColors.secondaryColor,
                ),
                labelColor: MyColors.whiteColor,
                unselectedLabelColor: MyColors.whiteColor,
                tabs: dates.asMap().entries.map((entry) {
                  int index = entry.key;
                  String date = entry.value;
                  return Tab(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.calendar_today, size: 18),
                          const SizedBox(width: 6),
                          Text('Day ${index + 1} - $date'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        backgroundColor: MyColors.ternaryColor,
        body: TabBarView(
          children: dates.map((formattedDate) {
            return AgendaList();
          }).toList(),
        ),
      ),
    );
  }
}
