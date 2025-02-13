import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:flutter/material.dart';

class CustomBigButton extends StatelessWidget {
  final VoidCallback action;
  final String text;
  const CustomBigButton({
    super.key,
    required this.action,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        width: ScreenSize.width * 0.85,
        height: 40,
        decoration: BoxDecoration(
            color: MyColors.secondaryColor,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: 18,
              color: MyColors.whiteColor,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}
