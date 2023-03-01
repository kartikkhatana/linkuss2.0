import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linkuss/pages/clubDetails.dart';
import 'package:linkuss/widgets/buttons.dart';

class ExploreClubs extends StatefulWidget {
  const ExploreClubs({super.key});

  @override
  State<ExploreClubs> createState() => _ExploreClubsState();
}

class _ExploreClubsState extends State<ExploreClubs> {
  Future? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data = getClubs();
  }

  DocumentReference docref =
      FirebaseFirestore.instance.collection('Colleges').doc("USS");

  Future getClubs() async {
    //get club details from post
    QuerySnapshot data = await docref.collection("Clubs").get();

    if (data.docs.isNotEmpty) {
      return data.docs;
    } else {
      return;
    }
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
                  "Explore Clubs",
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
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return clubItem(snapshot.data[index]);
                              }),
                        );
                      } else {
                        return Container();
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return Center(
                        child: Text(''),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget clubItem(final data) {
    return InkWell(
      onTap: () {
        Navigator.push(
         context,
         MaterialPageRoute(
         builder: (context) => ClubProfilePage(data)));
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
                    followStyleButton(0, callback: () {}, title: "Follow")
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
