import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:flutter/material.dart';

class CommonAppBar extends StatelessWidget {
  final String title;
  const CommonAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: MyColors.whiteColor,
          size: 22,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: MyColors.whiteColor),
      ),
      backgroundColor: MyColors.primayColor,
      centerTitle: true,
    );
  }
}
