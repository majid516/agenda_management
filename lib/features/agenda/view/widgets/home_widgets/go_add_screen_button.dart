import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:flutter/material.dart';

class GoAddScreenButton extends StatelessWidget {
  const GoAddScreenButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).pushNamed('/addTaskScreen'),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 30,
        decoration: BoxDecoration(
          color: MyColors.secondaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            '+ Add',
            style: TextStyle(
                fontSize: 17,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
