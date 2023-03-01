// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkuss/pages/login.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:linkuss/widgets/buttons.dart';

import '../bottombar.dart';

class EmailVerificationPage extends StatefulWidget {
  String email;
  String name;
  UserCredential userCredential;

  EmailVerificationPage(
      {required this.email, required this.name, required this.userCredential});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  String pagefont = 'Nunito Sans';
  Timer? timer;
  int counter = 30;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("called");
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      registerUser();
    } else {
      sendEmail();
      resendEmailTimer();
    }
    /*FirebaseAuth.instance.currentUser!.sendEmailVerification();

    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      checkEmailVerified();
    });*/
  }

  void resendEmailTimer() {
    counter = 30;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      counter -= 1;
      print(counter);
      if (counter == 0) {
        timer.cancel();
      }
    });
  }

  Future<void> registerUser() async {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BottomBar()));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Account Created Successfully")));
  }

  Future<void> sendEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email Sent Successfully"),
        duration: Duration(seconds: 3),
      ));
    } on FirebaseException catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code.toString()),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context)=> LoginPage()), (route) => false);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 45.0),
                      child: Text(
                        "Verify Email",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 200,
                child: Image.asset('assets/email_verification.png')),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "We have sent you an email verification link on your provided email. Please click it to verify your link. Also make sure to check your email spam folder if you didn't receive the verification link.",
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: primaryButton(double.infinity, callback: () {
                checkEmailVerified();
              }, title: "Done"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive verification email ?",
                  style: TextStyle(fontSize: 16),
                ),
                TextButton(
                  onPressed: () {
                    if (counter == 0) {
                      resendEmail();
                      if (!timer!.isActive) {
                        resendEmailTimer();
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Please wait for ${counter} seconds to resend email")));
                    }
                  },
                  child: Text(
                    "Resend Email",
                    style: TextStyle(fontSize: 16, color: MyColors.primary),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      registerUser();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You have been not verified please try again."),
        duration: Duration(seconds: 3),
      ));
    }
  }

  void resendEmail() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email Sent Successfully"),
        duration: Duration(seconds: 3),
      ));
    } on FirebaseException catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.code.toString()),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
