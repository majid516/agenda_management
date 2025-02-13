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
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Agendas',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            GoAddScreenButton()
          ],
        ),
      ),
      backgroundColor: MyColors.primayColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: DateHeadingsForTabIndicator(dates: dates),
      ),
    );
  }
}
