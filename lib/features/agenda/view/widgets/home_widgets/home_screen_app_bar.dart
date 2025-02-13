import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/widgets/home_widgets/date_headings_for_tab_indicator.dart';
import 'package:agenda_management/features/agenda/view/widgets/home_widgets/go_add_screen_button.dart';
import 'package:flutter/material.dart';

class HomeScreenAppBar extends StatelessWidget {
  const HomeScreenAppBar({
    super.key,
    required this.dates,
  });

  final List<String> dates;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10, top: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Agendas',
              style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GoAddScreenButton()
          ],
        ),
      ),
      backgroundColor: MyColors.primayColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child:dates.isEmpty ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('No Date Available',style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: MyColors.ternaryColor),),
        ) : DateHeadingsForTabIndicator(dates: dates),
      ),
    );
  }
}
