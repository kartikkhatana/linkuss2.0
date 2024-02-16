// import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkuss/currentUser.dart';
import 'package:linkuss/providers/basicProviders.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/utils/oldconstants.dart';
import 'package:linkuss/widgets/textfields.dart';
import 'package:uuid/uuid.dart';

import '../utils/constants.dart';

// List<comment> lt = List<comment>.generate(10, (index) => comment('p1'));
// var commentMap = FirebaseFirestore.instance
//     .collection("empty")
//     .doc("USS")
//     .collection("commets");

// List<comment> lt =[
//   comment('p1'),
//
// ];
class Commentsection extends ConsumerStatefulWidget {
  String uid;
  Commentsection(this.uid);
  @override
  ConsumerState<Commentsection> createState() => _CommentsectionState();
}

class _CommentsectionState extends ConsumerState<Commentsection> {
  final commentController = TextEditingController();
  var likedProvider;
  Future? postData;
  Future? getComments;
  Future addCommment() async {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String cid = Uuid().v4();
    Map<String, dynamic> comment = {
      "cid": cid,
      "value": commentController.text,
      "name": CurrentUser.fname,
      "timestamp": timestamp,
      "uid": FirebaseAuth.instance.currentUser!.uid
    };
    await FirebaseFirestore.instance
        .collection("CommentSection")
        .doc(widget.uid)
        .collection("Comments")
        .doc(cid)
        .set(comment, SetOptions(merge: true));
    await FirebaseFirestore.instance.collection("Posts").doc(widget.uid).update(
      {"commentCount": FieldValue.increment(1)},
    );
    ref.read(commentProvider.notifier).addAtFist(comment);
//    FirebaseFirestore.instance.collection("").add({}).then((value) => print(value.id));
  }

  Future deleteComment(String cid) async {
    await FirebaseFirestore.instance
        .collection("CommentSection")
        .doc(widget.uid)
        .collection("Comments")
        .doc(cid)
        .delete();
    await FirebaseFirestore.instance.collection("Posts").doc(widget.uid).update(
      {"commentCount": FieldValue.increment(-1)},
    );
    ref.read(commentProvider.notifier).deleteComment(cid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postData = getPostDetails();
    getComments = getCommentSection();
    //comments = List<Map<String, dynamic>>.from(widget.data['comments'] ?? []);
  }

  Future getPostDetails() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("Posts")
        .doc(widget.uid)
        .get();

    Map<String, dynamic> parsed =
        Map<String, dynamic>.from(data.data() as Map<String, dynamic>);

    return parsed;
  }

  Future getCommentSection() async {
    print(widget.uid);
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("CommentSection")
        .doc(widget.uid)
        .collection("Comments")
        .orderBy("timestamp", descending: true)
        .get();

    List<Map<String, dynamic>> dataList = [];

    data.docs.forEach((element) {
      Map<String, dynamic> parsed =
          Map<String, dynamic>.from(element.data() as Map<String, dynamic>);
      dataList.add(parsed);
    });

    return dataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: postData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  final likeCount = StateProvider.autoDispose(
                      (ref) => snapshot.data['likeCount']);

                  List<String> likedby =
                      List.from(snapshot.data['likedBy'] ?? []);
                  likedProvider = StateProvider.autoDispose((ref) =>
                      likedby.contains(FirebaseAuth.instance.currentUser!.uid));

                  return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: CustomScrollView(
                              slivers: [
                                SliverAppBar(
                                  leading: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context, {
                                        "likeCount": ref.read(likeCount),
                                        "commentCount":
                                            ref.read(commentProvider).length,
                                        "liked": ref.read(likedProvider)
                                      });
                                    },
                                    icon: Icon(Icons.arrow_back_ios),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  // title: Text("Details"),
                                  // centerTitle: true,
                                  // pinned: true,
                                  // shadowColor: MyColors.primary,
                                  // backgroundColor: MyColors.primary,
                                  //pinned: true,
                                  expandedHeight: 250.0,
                                  flexibleSpace: FlexibleSpaceBar(
                                    // title: Text('Goa', textScaleFactor: 1),
                                    background: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        snapshot.data['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                // SliverPersistentHeader(
                                //   pinned: true,
                                //   delegate: CustomSliverDelegate(snapshot.data['image'],
                                //       expandedHeight: 250),
                                // ),
                                SliverToBoxAdapter(
                                  child: Container(
                                    //height: MediaQuery.of(context).size.height - 250,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // Stack(
                                        //   children: [
                                        //     Container(
                                        //         height: MediaQuery.of(context).size.height / 2.75,
                                        //         decoration: BoxDecoration(
                                        //             borderRadius: BorderRadius.circular(20.0)),
                                        //         child: FittedBox(
                                        //             fit: BoxFit.fill,
                                        //             child: ClipRRect(
                                        //                 borderRadius: BorderRadius.circular(50.0),
                                        //                 child: Image(
                                        //                     image: NetworkImage(
                                        //                         snapshot.data['image']))))),
                                        //     // Positioned(
                                        //     //   top: 0,
                                        //     //   left: 0,
                                        //     //     child: Container(

                                        //     //   decoration: BoxDecoration(
                                        //     //     shape: BoxShape.circle,
                                        //     //     color: MyColors.primary,
                                        //     //   ),
                                        //     //   child: Center(
                                        //     //     child: IconButton(
                                        //     //       onPressed: () {
                                        //     //         Navigator.pop(context);
                                        //     //       },
                                        //     //       icon: Icon(
                                        //     //         Icons.arrow_back_ios,
                                        //     //         color: Colors.white,
                                        //     //       ),
                                        //     //     ),
                                        //     //   ),
                                        //     // ))
                                        //   ],
                                        // ),
                                        SizedBox(height: 10),
                                        Consumer(
                                            builder: (context, ref, child) {
                                          return Row(children: [
                                            IconButton(
                                              onPressed: () async {
                                                // FirebaseFirestore.instance
                                                //     .collection('Posts')
                                                //     .doc(postDetails['UID'])
                                                //     .update({
                                                //   'likedBy': FieldValue.arrayUnion([
                                                //     FirebaseAuth.instance.currentUser!.uid
                                                //   ])
                                                // });
                                                DocumentReference user =
                                                    FirebaseFirestore.instance
                                                        .collection('Users')
                                                        .doc(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid);
                                                if (!ref.read(likedProvider)) {
                                                  FirebaseFirestore.instance
                                                      .collection('Posts')
                                                      .doc(widget.uid)
                                                      .update({
                                                    'likedBy':
                                                        FieldValue.arrayUnion([
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                    ])
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('Posts')
                                                      .doc(widget.uid)
                                                      .update({
                                                    'likeCount':
                                                        FieldValue.increment(1)
                                                  });
                                                  user.update({
                                                    'likedPosts':
                                                        FieldValue.arrayUnion(
                                                            [widget.uid])
                                                  });
                                                  ref
                                                      .read(likeCount.notifier)
                                                      .state += 1;
                                                } else {
                                                  FirebaseFirestore.instance
                                                      .collection('Posts')
                                                      .doc(widget.uid)
                                                      .update({
                                                    'likedBy':
                                                        FieldValue.arrayRemove([
                                                      FirebaseAuth.instance
                                                          .currentUser!.uid
                                                    ])
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('Posts')
                                                      .doc(widget.uid)
                                                      .update({
                                                    'likeCount':
                                                        FieldValue.increment(-1)
                                                  });
                                                  user.update({
                                                    'likedPosts':
                                                        FieldValue.arrayRemove(
                                                            [widget.uid])
                                                  });
                                                  ref
                                                      .read(likeCount.notifier)
                                                      .state -= 1;
                                                }
                                                ref
                                                        .read(likedProvider
                                                            .notifier)
                                                        .state =
                                                    !ref.read(likedProvider);
                                              },
                                              icon: ref.watch(likedProvider)
                                                  ? FaIcon(
                                                      FontAwesomeIcons.thumbsUp,
                                                      color: Colors.blue,
                                                    )
                                                  : FaIcon(
                                                      FontAwesomeIcons.thumbsUp,
                                                      color: kiconColor,
                                                    ),
                                            ),
                                            // ref.watch(likedProvider)
                                            //     ? IconButton(
                                            //         onPressed: () {
                                            //           ref
                                            //                   .read(
                                            //                       likedProvider
                                            //                           .notifier)
                                            //                   .state =
                                            //               !ref.read(
                                            //                   likedProvider);
                                            //           ref
                                            //               .read(likeCount
                                            //                   .notifier)
                                            //               .state -= 1;
                                            //         },
                                            //         icon: FaIcon(
                                            //           FontAwesomeIcons.thumbsUp,
                                            //           color: Colors.blue,
                                            //         ),
                                            //       )
                                            //     : IconButton(
                                            //         onPressed: () {
                                            //           ref
                                            //                   .read(
                                            //                       likedProvider
                                            //                           .notifier)
                                            //                   .state =
                                            //               !ref.read(
                                            //                   likedProvider);
                                            //           ref
                                            //               .read(likeCount
                                            //                   .notifier)
                                            //               .state += 1;
                                            //         },
                                            //         icon: FaIcon(
                                            //           FontAwesomeIcons.thumbsUp,
                                            //           color: kiconColor,
                                            //         ),
                                            //       ),
                                            Text(
                                              ref.watch(likeCount).toString(),
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                            SizedBox(width: 20),
                                            FaIcon(
                                              FontAwesomeIcons.comment,
                                              color: kiconColor,
                                            ),
                                            SizedBox(width: 10),
                                            Consumer(
                                              builder: (context, ref, child) {
                                                return Text(
                                                  "${ref.watch(commentProvider).length}",
                                                  style:
                                                      TextStyle(fontSize: 14.0),
                                                );
                                              },
                                            ),
                                          ]);
                                        }),
                                        SizedBox(height: 10),
                                        Text(
                                          snapshot.data['title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(snapshot.data['description']),

                                        Divider(),
                                        SizedBox(height: 10),
                                        FutureBuilder(
                                            future: getComments,
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasData) {
                                                  Future.delayed(
                                                      Duration(seconds: 0), () {
                                                    ref
                                                        .read(commentProvider
                                                            .notifier)
                                                        .setValue(List<
                                                                Map<String,
                                                                    dynamic>>.from(
                                                            snapshot.data));
                                                  });
                                                  return Consumer(builder:
                                                      (context, ref, child) {
                                                    return ref
                                                                .watch(
                                                                    commentProvider)
                                                                .length !=
                                                            0
                                                        ? ListView.builder(
                                                            itemCount: ref
                                                                .watch(
                                                                    commentProvider)
                                                                .length,
                                                            shrinkWrap: true,
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return commentItem(
                                                                  ref.watch(
                                                                          commentProvider)[
                                                                      index]);
                                                            })
                                                        : Center(
                                                            child: Text(
                                                                "No Comments Found"),
                                                          );
                                                  });
                                                } else {
                                                  return Center(
                                                    child: Text(
                                                        "No Comments Found"),
                                                  );
                                                }
                                              } else if (snapshot
                                                      .connectionState ==
                                                  ConnectionState.waiting) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else {
                                                return Center(
                                                  child: Text(
                                                      'Something went wrong'),
                                                );
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              // color: Colors.white,

                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // CircleAvatar(
                                  //   radius: 20,
                                  //   backgroundImage: AssetImage('assets/ipulogo.png'),
                                  // ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: SizedBox(
                                      child: primaryTextField(
                                          hint: "Enter comment",
                                          controller: commentController),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      addCommment();
                                      commentController.clear();
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: MyColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
                } else {
                  return Center(
                    child:
                        Text('Something went wrong! Please try again later.'),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Center(
                  child: Text('Something went wrong! Please try again later.'),
                );
              }
            }),
      ),
    );
  }

  Widget commentItem(final data) {
    return Container(
        // color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CircleAvatar(
                //   radius: 20,
                //   backgroundImage: AssetImage('assets/ipulogo.png'),
                // ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data['name'],
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                Text(
                                  '8h ago',
                                  style: TextStyle(fontSize: 12.0),
                                ),
                                data['uid'] ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? IconButton(
                                        onPressed: () async {
                                          try {
                                            await deleteComment(
                                                data['cid'] ?? "");
                                          } catch (e) {
                                            print("Something went wrong");
                                          }
                                        },
                                        icon: Icon(Icons.delete))
                                    : Container()
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          data['value'],
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ]),
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider()
          ],
        ));
  }
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
          Opacity(
            opacity: percent,
            child: SizedBox(
              height: expandedHeight,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  // 'https://source.unsplash.com/random?mono+dark',
                  img,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Positioned(
          //   top: 10,
          //   left: 10,
          //     child: Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: MyColors.primary
          //       ),
          //       child: IconButton(
          //                 onPressed: () {},
          //                 icon: Icon(Icons.arrow_back,color: Colors.white,),
          //               ),
          //     ))
          // Positioned(
          //     left: 0.0,
          //     right: 0.0,
          //     bottom: 0,
          //     child: Opacity(
          //       opacity: percent,
          //       child: InkWell(
          //         child: Container(
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             border: Border.all(
          //               color: Colors.blue,
          //               width: 5,
          //             ),
          //           ),
          //           child: FittedBox(
          //             fit: BoxFit.scaleDown,
          //             child: CircleAvatar(
          //               backgroundColor: Colors.white,
          //               radius: 40,
          //               backgroundImage: NetworkImage(Constants.sdclogo),
          //             ),
          //           ),
          //         ),
          //         onTap: () {},
          //       ),
          //     )),
          // Positioned(
          //     right: 0.0,
          //     bottom: 0,
          //     child: Opacity(
          //         opacity: percent,
          //         child: IconButton(
          //           icon: const Icon(Icons.search),
          //           onPressed: () {},
          //         ))),
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
