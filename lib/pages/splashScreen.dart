import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linkuss/bottombar.dart';
import 'package:linkuss/currentUser.dart';
import 'package:linkuss/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
      if (FirebaseAuth.instance.currentUser != null) {
        DocumentReference ref = FirebaseFirestore.instance
            .collection('Users')
            .doc(FirebaseAuth.instance.currentUser!.uid);

        DocumentSnapshot userDetails = await ref.get();
        if (userDetails.data() != null) {
          //this method is so complicated due to firebase database bug opened in github
          Map<String, dynamic> data = jsonDecode(jsonEncode(userDetails.data()))
              as Map<String, dynamic>;
          if (data['status'] == 1) {
            CurrentUser.fname = data['fname'];
            CurrentUser.lname = data['lname'];
            CurrentUser.email = data['email'];
            CurrentUser.enrollNo = data['enrollNo'];
            CurrentUser.college = data['college'];
            CurrentUser.branch = data['branch'] ?? "";
            CurrentUser.following = List<String>.from(data['following'] ?? []);
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BottomBar()));
          } else {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }
        } else {
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        }
        //final prefs = await SharedPreferences.getInstance();

        // CurrentUser.fname = prefs.getString("fname") ?? "";
        // CurrentUser.lname = prefs.getString("lname") ?? "";
        // CurrentUser.email = prefs.getString("email") ?? "";
        // CurrentUser.enrollNo = prefs.getString("enrollNo") ?? "";
        // CurrentUser.branch = prefs.getString("branch") ?? "";
        // CurrentUser.college = prefs.getString("college") ?? "";

      } else {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "LinkIPU",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
