import 'package:agenda_management/common/components/sizes.dart';
import 'package:agenda_management/common/screen_size/screen_size.dart';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/widgets/components/member_stack.dart';
import 'package:flutter/material.dart';

class SelectMembersScreenElementsWidget extends StatelessWidget {
  const SelectMembersScreenElementsWidget({
    super.key,
    required this.selectedImages,
  });

  final List<String> selectedImages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: SizedBox(
        width: ScreenSize.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selected Members',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: MyColors.primayColor,
              ),
            ),
            Spaces.height10,
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MemberStack(
                    members: selectedImages,
                    avatarSize: 40,
                    showFullImage: true,
                    overlapOffset: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
