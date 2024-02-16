// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/utils/constants.dart';
import 'package:linkuss/widgets/buttons.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.primary,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: MyColors.primary,
                  ),
                ),
                Positioned(
                  top: 8,
                  left: MediaQuery.of(context).size.width / 3,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: kbackgroundColor,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.8),
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
                ],
              ),
            ),
            primaryButton(250, callback: () {}, title: '20 Following'),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.black12,
                  //     blurRadius: 3.0,
                  //     // spreadRadius: 0.5,
                  //     offset: Offset(1.0, 1.0),
                  //   )
                  // ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            'Liked Posts',
                            style: TextStyle(
                                color: tabController.index == 1
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Comments',
                            style: TextStyle(
                                color: tabController.index == 2
                                    ? Colors.white
                                    : Colors.black),
                          ),
                        ),
                      ],
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: MyColors.primary,
                      ),
                      controller: tabController,
                      isScrollable: true,
                      labelPadding: EdgeInsets.symmetric(horizontal: 40),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 18,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 6,
                          mainAxisSpacing: 6,
                        ),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 18,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        );
                      },
                    ),
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






   // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: GridView.builder(
            //       shrinkWrap: true,
            //       physics: const NeverScrollableScrollPhysics(),
            //       itemCount: 18,
            //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 3,
            //         crossAxisSpacing: 6,
            //         mainAxisSpacing: 6,
            //       ),
            //       itemBuilder: (context, index) {
            //         return Container(
            //           decoration: BoxDecoration(
            //             color: Colors.blueGrey,
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //         );
            //       }),
            // )