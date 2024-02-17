import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linkuss/currentUser.dart';
import 'package:linkuss/pages/clubDetails.dart';
import 'package:linkuss/widgets/buttons.dart';

class ExploreClubs extends StatefulWidget {
  const ExploreClubs({super.key});

  @override
  State<ExploreClubs> createState() => _ExploreClubsState();
}

class _ExploreClubsState extends State<ExploreClubs> {
  Future? data;
  List<String> followinglist = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getClubs();
  }

  Future getClubs() async {
    //get club details from post
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("Societies")
        .where('college', isEqualTo: CurrentUser.college)
        .get();

    await getFollowing();

    return data.docs;
  }

  Future getFollowing() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final data =
        Map<String, dynamic>.from(snapshot.data() as Map<String, dynamic>);
    followinglist = List<String>.from(data['following'] ?? []);
    print(followinglist);
  }

  Map<String, dynamic> parseDoc(final data) {
    return Map<String, dynamic>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios)),
                Text(
                  "Explore",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: data,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return snapshot.data.length != 0 ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return clubItem(snapshot.data[index]);
                              }),
                        ) : Center(
                          child: Text("No Clubs Found"),
                        );
                      } else {
                        return Center(
                          child: Text('No Clubs Found'),
                        );
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Text('Something went wrong'),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
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

  Widget clubItem(final data) {
    final following =
        StateProvider.autoDispose((ref) => followinglist.contains(data['UID']));
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ClubProfilePage(data)));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(data['image']),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 10),

                          //Text(data['followers'])
                        ],
                      ),
                    ),
                    Consumer(builder: (context, ref, child) {
                      return ref.watch(following)
                          ? followingStyleButton(0, callback: () {
                              setFollow(data['UID'],
                                  followinglist.contains(data['UID']));
                              followinglist.remove(data['UID']);
                              ref.read(following.notifier).state = false;
                            }, title: "Following")
                          : followStyleButton(0, callback: () {
                              setFollow(data['UID'],
                                  followinglist.contains(data['UID']));
                              followinglist.add(data['UID']);
                              ref.read(following.notifier).state = true;
                            }, title: "Follow");
                    })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
