import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkuss/pages/clubDetails.dart';
import 'package:linkuss/pages/commentpage.dart';
import 'package:linkuss/pages/explorepage.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/utils/constants.dart';
import 'package:linkuss/model/post_card.dart';
import 'package:linkuss/model/story.dart';

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
  //hello
  DocumentReference ref =
      FirebaseFirestore.instance.collection('Colleges').doc("USS");

  Future loadHomePageData() async {
    Map<String, dynamic> data = {};

    QuerySnapshot postDetails =
        await FirebaseFirestore.instance.collection("Posts").get();
    data['postDetails'] = postDetails.docs;

    //get list of the uids of the clubs
    List<String> postBy = [];
    for (var element in postDetails.docs) {
      dynamic data = element.data();
      Map<dynamic, dynamic> decoded = Map<dynamic, dynamic>.from(data);
      postBy.add(decoded['postBy']);
    }

    //get club details from post
    QuerySnapshot clubDetails =
        await ref.collection("Clubs").where('UID', whereIn: postBy).get();
    data['clubDetails'] = clubDetails.docs;

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
    // loadClubData();
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
        title: const Text(
          "LINKUSS",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.travel_explore,
              color: MyColors.primary,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ExploreClubs()));
            },
          )
        ],
        elevation: 0.0,
      ),
      body: FutureBuilder(
          future: loadHomePageData(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    SizedBox(height: 20),
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
                          Map<String, dynamic> post = parseDoc(
                              snapshot.data['postDetails'][index].data());
                          Map<String, dynamic> club = parseDoc(
                              snapshot.data['clubDetails'][index].data());
                          return postItem(club, post);
                        },
                        itemCount: snapshot.data['postDetails'].length,
                        physics: const BouncingScrollPhysics(),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text('Error loading dataaaa'),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('Error loading data'),
              );
            }
          }),
    );
  }

  Map<String, dynamic> parseDoc(final data) {
    return Map<String, dynamic>.from(data);
  }

  Widget postItem(final clubDetails, final postDetails) {
    final likedProvider = StateProvider.autoDispose((ref) => false);
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
                                '1d ago',
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
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Commentsection(postDetails)));
              },
              child: Column(
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
                          )),
                      decoration: BoxDecoration(
                          color: kblueColor,
                          borderRadius: BorderRadius.all(Radius.circular(25))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${postDetails['title']}: ',
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
                              return IconButton(
                                onPressed: () {
                                  ref.read(likedProvider.notifier).state =
                                      !ref.read(likedProvider);
                                },
                                icon: ref.watch(likedProvider)
                                    ? FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Colors.red,
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.heart,
                                        color: kiconColor,
                                      ),
                              );
                            },
                          ),
                          Text('${postDetails['likeCount']}'),
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
                        onPressed: () {},
                        icon: FaIcon(
                          FontAwesomeIcons.bookmark,
                          color: kiconColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
