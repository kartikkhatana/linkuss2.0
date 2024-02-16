import 'package:flutter/material.dart';
import 'package:linkuss/utils/constants.dart';

class StoryAvatar extends StatelessWidget {
  const StoryAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: PhysicalModel(
            color: Colors.black,
            elevation: 8.0,
            shape: BoxShape.circle,
            child: CircleAvatar(
              backgroundColor: kblueColor,
              radius: 35,
            ),
          ),
        ),
        Text('Story'),
      ],
    );
  }
}
