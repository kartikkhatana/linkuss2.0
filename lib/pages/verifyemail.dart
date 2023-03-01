import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:linkuss/bottombar.dart';

class VerifyEmailPage extends StatefulWidget {
  String email;
  String name;
  UserCredential userCredential;

  VerifyEmailPage(
      {required this.email, required this.name, required this.userCredential});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
 
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Text(
              "Verify Email",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "We have sent you an email verification link on your provided email please click it to verify your link. Also make sure to check your email spam folder if you didn't receive the verification link.",
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                height: 50,
                child: MaterialButton(
                  onPressed: () {
                    checkEmailVerified();
                  },
                  child: Text(
                    "DONE",
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  color: Colors.blue,
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Didn't receive verification email ?"),
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
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            )
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
