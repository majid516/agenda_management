import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:flutter/material.dart';

class DateHeadingsForTabIndicator extends StatelessWidget {
  const DateHeadingsForTabIndicator({
    super.key,
    required this.dates,
  });

  final List<String> dates;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: MyColors.primayColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: TabBar(
          dividerHeight: 0,
          indicatorPadding: EdgeInsets.symmetric(vertical: 7, horizontal: -10),
          isScrollable: true,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: MyColors.secondaryColor,
          ),
          labelColor: MyColors.whiteColor,
          unselectedLabelColor: MyColors.whiteColor,
        
          padding: EdgeInsets.zero,
          tabs: dates.asMap().entries.map((entry) {
            int index = entry.key;
            String date = entry.value;
            return Tab(
              
              child: Padding(
                padding:
                    const EdgeInsets.symmetric( vertical: 4.0),
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
    );
  }
}
