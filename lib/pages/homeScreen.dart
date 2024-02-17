import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkuss/currentUser.dart';
import 'package:linkuss/pages/clubDetails.dart';
import 'package:linkuss/pages/commentpage.dart';
import 'package:linkuss/pages/explorepage.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/utils/constants.dart';
import 'package:linkuss/model/post_card.dart';
import 'package:linkuss/model/story.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//test
class _HomeScreenState extends State<HomeScreen> {
  List<Widget> postList = [
    const PostCard(),
    const PostCard(),
    const PostCard(),
    const PostCard(),
    const PostCard(),
    const PostCard(),
  ];

  bool sort = true;
  Future<List<String>> updateFollowingClubs() async {
    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    Map<String, dynamic> parsed =
        Map<String, dynamic>.from(data.data() as Map<String, dynamic>);
    print(List.from(parsed['following'] ?? []));
    return List<String>.from(parsed['following'] ?? []);
  }

  Future loadHomePageData() async {
    CurrentUser.following = await updateFollowingClubs();
    Map<String, dynamic> data = {};
    QuerySnapshot postDetails;
    print(CurrentUser.following.toString());
    // if (!sort) {

    // } else {
    //   if (CurrentUser.following.isNotEmpty) {
    //     postDetails = await FirebaseFirestore.instance
    //         .collection("Posts")
    //         .where("filter", isEqualTo: CurrentUser.college)
    //         .where("postBy", whereIn: CurrentUser.following)
    //         .get();
    //     data['postDetails'] = postDetails.docs;
    //   } else {
    //     postDetails = await FirebaseFirestore.instance
    //         .collection("Posts")
    //         .where("filter", isEqualTo: CurrentUser.college)
    //         .get();
    //     data['postDetails'] = postDetails.docs;
    //   }
    // }

    postDetails = await FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("timestamp", descending: true)
        .where("filter", isEqualTo: CurrentUser.college)
        .get();
    data['postDetails'] = postDetails.docs;

    // postDetails = await FirebaseFirestore.instance
    //     .collection("Posts")
    //     .where("filter", isEqualTo: CurrentUser.college)
    //     .get();
    // data['postDetails'] = postDetails.docs;

    //get list of the uids of the clubs
    List<String> postBy = [];
    for (var element in postDetails.docs) {
      dynamic data = element.data();
      Map<dynamic, dynamic> decoded = Map<dynamic, dynamic>.from(data);
      postBy.add(decoded['postBy']);
    }

    print(postBy.toString());

    //get club details from post
    QuerySnapshot clubDetails = await FirebaseFirestore.instance
        .collection("Societies")
        .where('UID', whereIn: postBy)
        .where("college", isEqualTo: CurrentUser.college)
        .get();
    Map<String, dynamic> clubswithUID = {};

    clubDetails.docs.forEach((element) {
      final data = parseDoc(element.data());
      clubswithUID[data['UID']] = data;
    });

    print("clubs" + clubswithUID.toString());
    print("clubs" + clubswithUID['VpW8eCc4QwsM9yro7QAx'].toString());

    data['clubDetails'] = clubswithUID;

    if (clubDetails.docs.isNotEmpty && postDetails.docs.isNotEmpty) {
      return data;
    } else {
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFilterData();
    // loadClubData();
  }

  Future getFilterData() async {
    QuerySnapshot clubDetails = await FirebaseFirestore.instance
        .collection("Posts")
        .where('filter', isEqualTo: CurrentUser.college)
        .get();

    return clubDetails.docs;
  }

  // List<Widget> storyList = [
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  //   const StoryAvatar(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        // systemOverlayStyle: SystemUiOverlayStyle(
        //   statusBarColor: kbackgroundColor,
        // ),
        backgroundColor: kbackgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: SizedBox(
            child: Image.asset("assets/ipulogo.png"),
            width: 30,
            height: 30,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "LINKIPU",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(
          //     Icons.people,
          //     color: sort ? MyColors.primary : Colors.black,
          //   ),
          //   onPressed: () {
          //     setState(() {
          //       sort = !sort;
          //     });
          //     //   prtin
          //   },
          // ),
          IconButton(
            icon: const Icon(
              Icons.explore,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExploreClubs()));
            },
          ),
        ],
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: loadHomePageData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            // Stories (just for show)
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 10),
                            //   // child: ListView.builder(
                            //   //   itemBuilder: ((context, index) {
                            //   //     return storyList[index];
                            //   //   }),
                            //   //   itemCount: postList.length,
                            //   //   scrollDirection: Axis.horizontal,
                            //   //   physics: const BouncingScrollPhysics(),
                            //   // ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            //     children: const [
                            //       StoryAvatar(),
                            //       StoryAvatar(),
                            //       StoryAvatar(),
                            //       StoryAvatar(),
                            //     ],
                            //   ),
                            // ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> post = parseDoc(snapshot
                                      .data['postDetails'][index]
                                      .data());
                                  return postItem(
                                      snapshot.data['clubDetails']
                                          [post['postBy']],
                                      post);
                                },
                                itemCount: snapshot.data['postDetails'].length,
                                physics: const BouncingScrollPhysics(),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Center(
                          child: Text('No Posts Found'),
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Text('Error loading data'),
                      );
                    }
                  }))
        ],
      ),
    );
  }

  Map<String, dynamic> parseDoc(final data) {
    return Map<String, dynamic>.from(data);
  }

  Widget postItem(final clubDetails, final postDetails) {
    DateTime postTime = DateTime.fromMillisecondsSinceEpoch(postDetails['timestamp']);
    DateTime now = DateTime.now();
    Duration difference = now.difference(postTime);
    String timeAgo;

    if (difference.inDays > 0) {
      timeAgo = '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      timeAgo = '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else {
      timeAgo = '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    }
    List<String> likedby = List.from(postDetails['likedBy'] ?? []);
    final likedProvider = StateProvider.autoDispose(
        (ref) => likedby.contains(FirebaseAuth.instance.currentUser!.uid));
    final likedCount =
        StateProvider.autoDispose((ref) => postDetails['likeCount'] ?? 0);
    final commentCount =
        StateProvider.autoDispose((ref) => postDetails['commentCount'] ?? 0);
    // Map<String, dynamic> info = {};
    // info['postDetails'] = postDetails.docs;
    // int n = info['likeCount'];
    // for (int i = 0; i < n; i++) {
    //   if (info['likedby'][i] == curuser) {
    //     liked = true;
    //     break;
    //   }
    // }

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
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ClubProfilePage(clubDetails)));
              },
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
                              backgroundImage:
                                  NetworkImage(clubDetails['image']),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${clubDetails['name']}',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                timeAgo,
                                style: TextStyle(color: kiconColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Commentsection(postDetails['UID'])))
                        .then((value) {
                      ref.read(likedCount.notifier).state = value['likeCount'];
                      ref.read(commentCount.notifier).state =
                          value['commentCount'];
                      ref.read(likedProvider.notifier).state = value['liked'];
                      print("exited");
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                          width: double.infinity,
                          height: 280,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                postDetails['image'],
                                fit: BoxFit.cover,
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    );
                                  }
                                },
                              )),
                          decoration: BoxDecoration(
                              color: kblueColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${postDetails['title']}',
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${postDetails['description']}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Consumer(
                                builder: (context, ref, child) {
                                  return Row(
                                    children: [
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
                                              FirebaseFirestore
                                                  .instance
                                                  .collection('Users')
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid);
                                          if (!ref.read(likedProvider)) {
                                            FirebaseFirestore.instance
                                                .collection('Posts')
                                                .doc(postDetails['UID'])
                                                .update({
                                              'likedBy': FieldValue.arrayUnion([
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                              ])
                                            });
                                            FirebaseFirestore.instance
                                                .collection('Posts')
                                                .doc(postDetails['UID'])
                                                .update({
                                              'likeCount':
                                                  FieldValue.increment(1)
                                            });
                                            user.update({
                                              'likedPosts':
                                                  FieldValue.arrayUnion(
                                                      [postDetails['UID']])
                                            });
                                            ref
                                                .read(likedCount.notifier)
                                                .state += 1;
                                          } else {
                                            FirebaseFirestore.instance
                                                .collection('Posts')
                                                .doc(postDetails['UID'])
                                                .update({
                                              'likedBy':
                                                  FieldValue.arrayRemove([
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                              ])
                                            });
                                            FirebaseFirestore.instance
                                                .collection('Posts')
                                                .doc(postDetails['UID'])
                                                .update({
                                              'likeCount':
                                                  FieldValue.increment(-1)
                                            });
                                            user.update({
                                              'likedPosts':
                                                  FieldValue.arrayRemove(
                                                      [postDetails['UID']])
                                            });
                                            ref
                                                .read(likedCount.notifier)
                                                .state -= 1;
                                          }
                                          ref
                                              .read(likedProvider.notifier)
                                              .state = !ref.read(likedProvider);
                                        },
                                        icon: ref.watch(likedProvider)
                                            ? const FaIcon(
                                                FontAwesomeIcons.solidThumbsUp,
                                                color: Colors.blue,
                                              )
                                            : const FaIcon(
                                                FontAwesomeIcons.thumbsUp,
                                                color: kiconColor,
                                              ),
                                      ),
                                      Text('${ref.watch(likedCount)}'),
                                    ],
                                  );
                                },
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Commentsection(postDetails['UID'])));
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.comment,
                                  color: kiconColor,
                                ),
                              ),
                              Text("${ref.watch(commentCount)}"),
                            ],
                          ),
                          // IconButton(
                          //   onPressed: () {},
                          //   icon: FaIcon(
                          //     FontAwesomeIcons.bookmark,
                          //     color: kiconColor,
                          //   ),
                          // ),
                        ],
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
