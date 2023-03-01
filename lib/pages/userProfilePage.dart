// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/utils/constants.dart';
import 'package:linkuss/widgets/buttons.dart';

import '../currentUser.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  const UserProfilePage({super.key});

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  final tabProvider = StateProvider.autoDispose((ref) => 0);

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
      backgroundColor: MyColors.bgcolor,
      body: CustomScrollView(slivers: [
        SliverPersistentHeader(
          delegate: CustomSliverDelegate("", expandedHeight: 200),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 70,
                  bottom: 12,
                ),
                child: Column(
                  children: [
                    Text(
                      '${capitalize(CurrentUser.fname)} ${capitalize(CurrentUser.lname)}',
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${CurrentUser.college} ${CurrentUser.branch}',
                      style: TextStyle(fontSize: 16, color: kiconColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              followStyleButton(250, callback: () {}, title: '20 Following'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Container(
                  decoration: BoxDecoration(
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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: TabBar(
                          onTap: (index) {
                            ref.read(tabProvider.notifier).state = index;
                          },
                          tabs: [
                            Tab(
                              child: Text(
                                'Liked Posts',
                                style: TextStyle(
                                    color: tabController.index == 0
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Comments',
                                style: TextStyle(
                                    color: tabController.index == 1
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ],
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: MyColors.primary,
                          ),
                          controller: tabController,
                          isScrollable: true,
                          labelPadding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ref.watch(tabProvider) == 0
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
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
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                          padding: EdgeInsets.zero,
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
            ],
          ),
        )
        // Slive
      ]),
    );
  }
}

String capitalize(String str) {
  return str[0].toUpperCase() + str.substring(1,str.length);
}

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  String img;
  CustomSliverDelegate(
    this.img, {
    required this.expandedHeight,
    this.hideTitleWhenExpanded = true,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final appBarSize = expandedHeight - shrinkOffset;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    return SizedBox(
      height: expandedHeight + expandedHeight / 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Opacity(
          //   opacity: percent,
          //   child: SizedBox(
          //     height: expandedHeight,
          //     width: double.infinity,
          //     child: Image.network(
          //       // 'https://source.unsplash.com/random?mono+dark',
          //       img,
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          // ),
          Opacity(
              opacity: percent,
              child: SizedBox(
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                        'https://i.pinimg.com/236x/ef/b7/41/efb741d3b6d3ee496e971537b0834505--summer-hairstyles-new-hairstyles.jpg',
                        fit: BoxFit.cover),
                    ClipRRect(
                      // Clip it cleanly.
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          color: Colors.grey.withOpacity(0.1),
                          alignment: Alignment.center,
                          // child: Text('CHOCOLATE'),
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Opacity(
          //     opacity: percent,
          //     child: CircleAvatar(
          //       radius: 70,
          //       backgroundColor: kbackgroundColor,
          //       child: CircleAvatar(
          //         backgroundColor: Colors.black.withOpacity(0.8),
          //         radius: 65,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
              right: 10,
              top: 40,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),
              )),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: -65,
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: MyColors.primary,
                    width: 5,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: kbackgroundColor,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://i.pinimg.com/236x/ef/b7/41/efb741d3b6d3ee496e971537b0834505--summer-hairstyles-new-hairstyles.jpg"),
                      backgroundColor: Colors.black.withOpacity(0.8),
                      radius: 65,
                    ),
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight + 45;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
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
