import 'package:flutter/material.dart';

class PositionedAvatar extends StatelessWidget {
  final double size;
  final String imageUrl;
  final int index;

  const PositionedAvatar(
      {super.key, required this.imageUrl, required this.index, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(70),
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            imageUrl,
            fit: BoxFit.cover,
          )),
    );
  }
}
