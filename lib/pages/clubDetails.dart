import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:linkuss/currentUser.dart';
import 'package:linkuss/pages/commentpage.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/widgets/buttons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';
import '../utils/oldconstants.dart';

class ClubProfilePage extends ConsumerStatefulWidget {
  final data;
  ClubProfilePage(this.data);
  @override
  ConsumerState<ClubProfilePage> createState() => _ClubProfilePageState();
}

class _ClubProfilePageState extends ConsumerState<ClubProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String selectedTab = "Team";
  final tabProvider = StateProvider.autoDispose((ref) => 0);
  Future? clubPosts;
  late final following;
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'sdcusict@ipu.ac.in',
  );
  @override
  void initState() {
    super.initState();
    following = StateProvider.autoDispose(
        (ref) => CurrentUser.following.contains(widget.data['UID']));
    tabController = TabController(length: 3, vsync: this);
    clubPosts = getClubPosts();
  }

  Future getClubPosts() async {
    //get club details from post
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("Posts")
        .where('postBy', isEqualTo: widget.data['UID']!)
        .get();

    if (data.docs.isNotEmpty) {
      return data.docs;
    } else {
      return;
    }
  }

  void setFollow(String uid, bool ispresent) {
    if (ispresent) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'following': FieldValue.arrayRemove([uid])
        },
      );
    } else {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update(
        {
          'following': FieldValue.arrayUnion([uid])
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // StateController<bool> isFollowing = ref.watch(following.notifier);

    // StateController<int> counter = ref.watch(counterProvider.notifier);
    // isFollowing.state = CurrentUser.following.contains(widget.data['UID']);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Consumer(
        builder: (context, value, child) {
          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                delegate: CustomSliverDelegate(widget.data['image'],
                    expandedHeight: 200),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // InkWell(
                    //     onTap: () {
                    //       counter.state++;
                    //     },
                    //     child: Text(ref.watch(counterProvider).toString())),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      widget.data['name'],
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            widget.data['description'],
                            textAlign: TextAlign.center,
                          )),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Consumer(builder: (context, ref, child) {
                        //   return ref.watch(following)
                        //       ? primaryButton(
                        //           MediaQuery.of(context).size.width / 3,
                        //           callback: () {
                        //           setFollow(
                        //               widget.data['UID'],
                        //               CurrentUser.following
                        //                   .contains(widget.data['UID']));
                        //           ref.read(following.notifier).state = false;
                        //           CurrentUser.following
                        //               .remove(widget.data['UID']);
                        //         }, title: "Following", btnColor: Colors.blue)
                        //       : primaryButton(
                        //           MediaQuery.of(context).size.width / 3,
                        //           callback: () {
                        //           setFollow(
                        //               widget.data['UID'],
                        //               CurrentUser.following
                        //                   .contains(widget.data['UID']));
                        //           ref.read(following.notifier).state = true;
                        //           CurrentUser.following.add(widget.data['UID']);
                        //         }, title: "Follow");
                        // }),
                        // CurrentUser.following.contains() ?  primaryButton(MediaQuery.of(context).size.width / 3,
                        //     callback: () {}, title: "Follow"),
                        primaryButton(MediaQuery.of(context).size.width / 3,
                            callback: () {
                          launchUrl(emailLaunchUri);
                        }, title: "Mail Us")
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              height: 50,
                              child: TabBar(
                                indicatorColor: MyColors.primary,
                                onTap: (index) {
                                  ref.read(tabProvider.notifier).state = index;
                                  // value.setSelectedTab = index;
                                },
                                tabs: const <Widget>[
                                  Tab(
                                    child: SizedBox(
                                        height: 25,
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "Team",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ))),
                                  ),
                                  Tab(
                                    child: SizedBox(
                                        height: 25,
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "Posts",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ))),
                                  ),
                                  Tab(
                                    child: SizedBox(
                                        height: 25,
                                        child: Padding(
                                            padding: EdgeInsets.only(top: 5.0),
                                            child: Text(
                                              "Events",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ))),
                                  ),
                                ],
                                controller: tabController,

                                labelColor: Colors.white,
                                //unselectedLabelColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    returnSelectedTab()
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget returnSelectedTab() {
    switch (ref.watch(tabProvider)) {
      case 0:
        return TeamTab(widget.data['members']);
      case 1:
        return PostsTab();
      case 2:
      default:
        return Container(
          height: 100,
          child: Center(child: Text("No Events Found")),
        );
    }
  }

  Widget PostsTab() {
    return FutureBuilder(
        future: clubPosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(5.0),
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Commentsection(
                                    snapshot.data[index]['UID'])));
                      },
                      child: Container(
                        child: Image.network(
                          snapshot.data[index]['image'],
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black12,
                        height: 200,
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(1),
                ),
              );
            } else {
              return Container();
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text(''),
            );
          }
        });
  }
}

Widget TeamTab(final data) {
  return Column(
    children: [
      const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Faculty",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ))),
      data['faculty'].length != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List<Widget>.from(data['faculty'].map((e) {
                      return facultyListItem(e);
                    }).toList()),
                  ),
                ),
              )),
            )
          : Container(
              height: 100, child: Center(child: Text("No Faculty Found"))),
      const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                "Students",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ))),
      data['students'].length != 0
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                  child: Align(
                alignment: Alignment.centerLeft,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List<Widget>.from(data['students'].map((e) {
                      return studentListItem(e);
                    }).toList()),
                  ),
                ),
              )),
            )
          : Container(
              height: 100, child: Center(child: Text("No Students Found"))),
      const SizedBox(
        height: 40.0,
      )
    ],
  );
}

Widget facultyListItem(final data) {
  return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  data['image'],
                  fit: BoxFit.cover,
                )),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(30.0)),
          ),
          SizedBox(height: 10),
          Text(
            data['name'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(data['profession']),
        ],
      ));
}

Widget studentListItem(final data) {
  return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5.0,
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            width: 120,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  data['image'],
                  fit: BoxFit.cover,
                )),
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(30.0)),
          ),
          SizedBox(height: 10),
          Text(
            data['position'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(data['name']),
          SizedBox(height: 10),
          Text("${data['branch']} ${data['college']}"),
        ],
      ));
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
        children: [
          Opacity(
            opacity: percent,
            child: SizedBox(
              height: expandedHeight,
              width: double.infinity,
              child: Image.network(
                // 'https://source.unsplash.com/random?mono+dark',
                img,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0,
              child: Opacity(
                opacity: percent,
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
                        backgroundColor: Colors.white,
                        radius: 40,
                        backgroundImage: NetworkImage(img),
                      ),
                    ),
                  ),
                  onTap: () {},
                ),
              )),
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
