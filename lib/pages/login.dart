import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:linkuss/bottombar.dart';
import 'package:linkuss/currentUser.dart';
import 'package:linkuss/pages/register.dart';
import 'package:linkuss/pages/verifyemail.dart';

import '../widgets/buttons.dart';
import '../widgets/textfields.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
            ),
            Text(
              "LINKUSS",
              style: TextStyle(
                color: Colors.black,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Sign In to Continue",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Align(
                    alignment: Alignment.center,
                    child: primaryTextField(
                        controller: emailC,
                        hint: "Email",
                        prefix: Icon(Icons.email)))),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Align(
                    alignment: Alignment.center,
                    child: primaryTextField(
                        obscureText: true,
                        controller: passC,
                        hint: "Password",
                        prefix: Icon(Icons.lock)))),
            Container(
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Align(
                    alignment: Alignment.center,
                    child: primaryButton(MediaQuery.of(context).size.width / 2,
                        callback: () {
                      login();
                    }, title: "Login"))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dont have an account ?"),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text("Create Account"),
                ),
              ],
            )
          ],
        )),
      ),
    );
  }

  void login() async {
    if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
      if (emailC.text.toLowerCase().endsWith('ipu.ac.in')) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailC.text, password: passC.text);
          DocumentReference ref = FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.uid);
          DocumentSnapshot userDetails = await ref.get();

          if (userDetails.data() != null) {
            //this method is so complicated due to firebase database bug opened in github
            Map<String, dynamic> data =
                jsonDecode(jsonEncode(userDetails.data()))
                    as Map<String, dynamic>;
            if (data['status'] == 1) {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BottomBar()));
              CurrentUser.fname = data['fname'];
              CurrentUser.lname = data['lname'];
              CurrentUser.email = data['email'];
              CurrentUser.enrollNo = data['enrollNo'];
              CurrentUser.college = data['college'];
              CurrentUser.branch = data['branch'];
              // if (userCredential.user!.emailVerified) {
              //   // UserDetails user = UserDetails(
              //   //     name: data['name'],
              //   //     email: data['email'],
              //   //     premium: data['premium']);
              //   // CurrentUser.user = user;
              //   // final prefs = await SharedPreferences.getInstance();
              //   // await prefs.setString('name', user.name);
              //   // await prefs.setString('email', user.email);
              //   // HelperFunction.updateUserInfo(auth);

              //   // ignore: use_build_context_synchronously
              //   // Navigator.pop(context);
              //   // ignore: use_build_context_synchronously
              //   /* Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => const HomePage()));*/

              // } else {
              //   Navigator.pop(context);
              //   // ignore: use_build_context_synchronously
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => VerifyEmailPage(
              //                 email: data['email'],
              //                 name: data['fname'],
              //                 userCredential: userCredential,
              //               )));
              // }
            } else {
              // FirebaseAuth.instance.signOut();
              // final prefs = await SharedPreferences.getInstance();
              // prefs.clear();
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text(
              //         "Error Logging in! - Your account was disabled temporarily")));
            }
          } else {
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Something went wrong ! Please try again.'),
              duration: Duration(seconds: 3),
            ));
          }
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Incorrect email id'),
              duration: Duration(seconds: 3),
            ));
          } else if (e.code == 'wrong-password') {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Incorrect password'),
              duration: Duration(seconds: 3),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(e.code.toString()),
              duration: Duration(seconds: 3),
            ));
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please Enter Correct GGSIPU Email Address.'),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill all the above fields'),
        duration: Duration(seconds: 3),
      ));
    }
  }
}
