// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/utils/oldconstants.dart';
import 'package:linkuss/widgets/textfields.dart';

import '../utils/constants.dart';

List<comment> lt = List<comment>.generate(10, (index) => comment('p1'));

// List<comment> lt =[
//   comment('p1'),
//
// ];
class Commentsection extends StatefulWidget {
  final data;
  Commentsection(this.data);
  @override
  State<Commentsection> createState() => _CommentsectionState();
}

class _CommentsectionState extends State<Commentsection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
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
                              widget.data['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // SliverPersistentHeader(
                      //   pinned: true,
                      //   delegate: CustomSliverDelegate(widget.data['image'],
                      //       expandedHeight: 250),
                      // ),
                      SliverToBoxAdapter(
                        child: Container(
                          //height: MediaQuery.of(context).size.height - 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              //                         widget.data['image']))))),
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
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: [
                                      IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.heart,
                                          color: kiconColor,
                                        ),
                                      ),
                                      Text(
                                        widget.data['likeCount'].toString(),
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                      SizedBox(width: 15.0),
                                      IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.comment,
                                          color: kiconColor,
                                        ),
                                      ),
                                      Text(
                                        '27',
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ]),
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(Icons.save, size: 20.0),
                                    // ),
                                  ]),
                              SizedBox(height: 10),
                              Text(
                                widget.data['title'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(widget.data['description']),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: lt,
                              ),
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
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('asset/Koala.jpg'),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                            child: SizedBox(
                          child: primaryTextField(hint: "Enter comment"),
                        ))
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class comment extends StatelessWidget {
  String person;
  comment(this.person);

  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('asset/Koala.jpg'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              person,
                              style: TextStyle(
                                  fontSize: 15.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '8h ago',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "helo its first comment As an intellectual object, a book is prototypically a composition of such great length that it takes a considerable investment of time to compose ",
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ]),
                ),
                Divider(
                  color: Color(0x9c000000),
                  height: 10.0,
                )
              ],
            ),
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
