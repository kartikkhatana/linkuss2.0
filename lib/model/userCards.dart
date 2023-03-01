import 'package:flutter/material.dart';
import 'package:linkuss/utils/constants.dart';

class UserCards extends StatelessWidget {
  final String title;
  final Icon icon;

  final List userCardItemList;

  UserCards(
      {required this.title,
      required this.icon,
      required this.userCardItemList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kbackgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              // spreadRadius: 5,
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: ExpansionTile(
            title: Text(title),
            leading: icon,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Text(userCardItemList[index]);
                  },
                  itemCount: userCardItemList.length,
                  // physics: const BouncingScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


      // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(userCardItemList[0]),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(userCardItemList[1]),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(userCardItemList[2]),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(userCardItemList[3]),
              // ),