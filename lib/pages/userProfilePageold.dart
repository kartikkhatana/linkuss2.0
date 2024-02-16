// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:linkuss/model/userCards.dart';
import 'package:linkuss/utils/constants.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kblueColor,
        leading: const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.chevron_left,
            color: Colors.black54,
            size: 35,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.black54,
            ),
            onPressed: () {
              // open settings
            },
          )
        ],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: kblueColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(75),
                    bottomRight: Radius.circular(75),
                  ),
                ),
              ),
              Positioned(
                top: 15,
                left: MediaQuery.of(context).size.width / 3,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: kbackgroundColor,
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 65,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 70,
              bottom: 12,
            ),
            child: Column(
              children: [
                Text(
                  'Yash Khattar',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'USICT IT (2022-26)',
                  style: TextStyle(fontSize: 16, color: kiconColor),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '20 Following',
                      style: TextStyle(fontSize: 16, color: kiconColor),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        height: 16,
                        width: 1,
                        color: kiconColor,
                      ),
                    ),
                    Text(
                      '20 Following',
                      style: TextStyle(fontSize: 16, color: kiconColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                UserCards(
                  title: 'About Me',
                  icon: Icon(Icons.person),
                  userCardItemList: [
                    'Name',
                    'IPU Email',
                    'Enrollement no',
                    'Branch',
                    'College',
                    'Year'
                  ],
                ),
                UserCards(
                  title: 'My Clubs',
                  icon: Icon(Icons.person),
                  userCardItemList: [
                    'SDC GGSIPU',
                    'TechSpace',
                    'ACM',
                    'Aveksha'
                  ],
                ),
                UserCards(
                  title: 'My Events',
                  icon: Icon(Icons.person),
                  userCardItemList: [
                    'InfoExpression',
                    'Hackathon',
                    'Anugunj',
                    'Aveksha'
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Name (String)

// IPU Email (String)

// Enrollment No. (String)

// Branch (String)

// College (String)

// Year (String)

// body: Column(
//   children: [
//     Container(
//       height: 80,
//       decoration: const BoxDecoration(
//         color: kblueColor,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(100),
//           bottomRight: Radius.circular(100),
//         ),
//       ),
//       child: Stack(children: [
//         Positioned(
//           top: 20,
//           left: MediaQuery.of(context).size.width / 3,
//           child: const CircleAvatar(
//             backgroundColor: Colors.yellow,
//             radius: 70,
//           ),
//         ),
//       ]),
//     ),
//     const Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Text(
//         'Yash Khattar',
//         style: TextStyle(fontSize: 24),
//       ),
//     ),
//     const Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Text(
//         "USICT'26",
//         style: TextStyle(fontSize: 18),
//       ),
//     ),
//   ],
// ),
