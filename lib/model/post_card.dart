// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:linkuss/utils/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostCard extends StatefulWidget {
  const PostCard({super.key});

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  bool isSaved = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      child: Container(
        decoration: BoxDecoration(
          color: kbackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        backgroundColor: kblueColor,
                        radius: 26,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SDC GGSIPU',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '1d ago',
                          style: TextStyle(color: kiconColor),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    color: kiconColor,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                width: double.infinity,
                height: 280,
                decoration: BoxDecoration(
                    color: kblueColor,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SDC GGSIPU : ',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                      'This is a sample description of the post!',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                      icon: FaIcon(
                        isLiked
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: isLiked ? Colors.red : kiconColor,
                      ),
                    ),
                    Text('4K'),
                    IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.comment,
                        color: kiconColor,
                      ),
                    ),
                    Text('2K'),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isSaved = !isSaved;
                    });
                  },
                  icon: FaIcon(
                    isSaved
                        ? FontAwesomeIcons.solidBookmark
                        : FontAwesomeIcons.bookmark,
                    color: isSaved ? Colors.yellow : kiconColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
