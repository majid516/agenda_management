import 'dart:math';
import 'package:agenda_management/common/theme/color_theme.dart';
import 'package:agenda_management/features/agenda/view/widgets/home_widgets/positioned_avatar.dart';
import 'package:flutter/material.dart';

class MemberStack extends StatelessWidget {
  final bool showFullImage;
  final List<String> members;
  final double avatarSize;
  final double overlapOffset;

  const MemberStack(
      {super.key,
      required this.members,
      this.avatarSize = 26,
      this.showFullImage = false,
      this. overlapOffset = 16,
      });

  @override
  Widget build(BuildContext context) {

    final int displayCount =
        !showFullImage ? min(members.length, 3) : members.length;

    double stackWidth = (displayCount - 1) * overlapOffset + avatarSize;

    if (members.length > 3) {
      stackWidth += overlapOffset;
    }

    return SizedBox(
      width: stackWidth,
      height: avatarSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < displayCount; i++)
            Positioned(
              left: i * overlapOffset,
              child: PositionedAvatar(
                imageUrl: members[i],
                index: i,
                size: avatarSize,
              ),
            ),
          if (!showFullImage)
            if (members.length > 3)
              Positioned(
                left: displayCount * overlapOffset,
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: MyColors.whiteColor,
                  child: Text(
                    '+${members.length - 3}',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
