import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:linkuss/pages/emailVerificationPage.dart';
import 'package:linkuss/pages/login.dart';
import 'package:linkuss/pages/verifyemail.dart';
import 'package:linkuss/utils/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:intl/intl.dart';
import '../widgets/buttons.dart';
import '../widgets/textfields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final fnameC = TextEditingController();
  final lnameC = TextEditingController();
  final emailC = TextEditingController();
  final passC = TextEditingController();
  final confirmpassC = TextEditingController();
  final enrollNoC = TextEditingController();
  final startingYear = TextEditingController();
  final endingYear = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  CollectionReference miscRef = FirebaseFirestore.instance.collection('Misc');
  Future<DocumentSnapshot>? collegeData;
  String? college;
  String? branch;
  bool accept = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    collegeData = miscRef.doc("collegeData").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 248, 253),
      body: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: collegeData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    Map<String, dynamic> data =
                        jsonDecode(jsonEncode(snapshot.data!.data()))
                            as Map<String, dynamic>;
                    print(data);
                    print(data['USICT']['branches']);
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: 30),
                          Text(
                            "Register",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Lets get you started",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: MediaQuery.of(context).size.width - 30,
                            padding: EdgeInsets.symmetric(vertical: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: primaryTextField(
                                          controller: fnameC,
                                          hint: "First Name",
                                          prefix: Icon(Icons.person),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: primaryTextField(
                                          controller: lnameC,
                                          hint: "Last Name",
                                          prefix: Icon(Icons.person),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: primaryTextField(
                                            controller: emailC,
                                            hint: "GGSIPU Email",
                                            prefix: Icon(Icons.mail)))),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: primaryTextField(
                                            obscureText: true,
                                            controller: passC,
                                            hint: "Password",
                                            prefix: Icon(Icons.lock)))),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: primaryTextField(
                                            obscureText: true,
                                            controller: confirmpassC,
                                            hint: "Confirm Password",
                                            prefix: Icon(Icons.lock)))),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: primaryTextField(
                                            controller: enrollNoC,
                                            hint: "Enrollment Number",
                                            prefix: Icon(Icons.book)))),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: DropdownButtonFormField<String>(
                                    isDense: true,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      prefixIcon: Icon(Icons.book),
                                      contentPadding: EdgeInsets.all(12),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                    ),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    isExpanded: true,
                                    hint: const Text("Select College"),
                                    value: college,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    onChanged: (String? value) {
                                      // This is called when the user selects an item.
                                      setState(() {
                                        college = value!;
                                      });
                                    },
                                    items: data.keys
                                        .toList()
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                college != null
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: DropdownButtonFormField<String>(
                                          isDense: true,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            prefixIcon: Icon(Icons.book),
                                            contentPadding: EdgeInsets.all(12),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.black12)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.black12)),
                                          ),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black),
                                          isExpanded: true,
                                          hint: const Text("Select Branch"),
                                          value: branch,
                                          icon:
                                              const Icon(Icons.arrow_drop_down),
                                          elevation: 16,
                                          onChanged: (String? value) {
                                            // This is called when the user selects an item.
                                            setState(() {
                                              branch = value!;
                                            });
                                          },
                                          items: List<String>.from(
                                                  data[college]['branches'])
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      )
                                    : Container(),
                                // Padding(
                                //     padding: EdgeInsets.symmetric(
                                //         vertical: 10, horizontal: 20),
                                //     child: Align(
                                //         alignment: Alignment.center,
                                //         child: primaryTextField(
                                //             onTap: () {
                                //               print("hello");
                                //               DateT
                                //               return ;
                                //             },
                                //             readOnly: true,
                                //             hint: "Starting Year",
                                //             prefix: Icon(Icons
                                //                 .calendar_month_outlined)))),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: DateTimePicker(
                                    style: TextStyle(fontSize: 14),
                                    controller: startingYear,
                                    decoration: InputDecoration(
                                      hintText: "Starting Year",
                                      isDense: true,
                                      prefixIcon: Icon(Icons.calendar_month),
                                      contentPadding: EdgeInsets.all(12),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                    ),
                                    firstDate:
                                        DateTime(DateTime.now().year - 6),
                                    lastDate: DateTime(DateTime.now().year + 6),
                                    dateLabelText: 'Date',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: DateTimePicker(
                                    controller: endingYear,
                                    style: TextStyle(fontSize: 14),
                                    decoration: InputDecoration(
                                      hintText: "Ending Year",
                                      isDense: true,
                                      prefixIcon: Icon(Icons.calendar_month),
                                      contentPadding: EdgeInsets.all(12),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide(
                                              color: Colors.black12)),
                                    ),
                                    firstDate:
                                        DateTime(DateTime.now().year - 6),
                                    lastDate: DateTime(DateTime.now().year + 6),
                                    dateLabelText: 'Date',
                                    onChanged: (val) => print(val),
                                    validator: (val) {
                                      print(val);
                                      return null;
                                    },
                                    onSaved: (val) => print(val),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: accept,
                                onChanged: (value) {
                                  setState(() {
                                    accept = !accept;
                                  });
                                },
                                activeColor: MyColors.primary,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 60,
                                child: Text(
                                  "I accept all the above information is correct and any false information may lead to my account suspension.",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: primaryButton(
                                      MediaQuery.of(context).size.width / 2,
                                      callback: () {
                                    signup();
                                  }, title: "Register"))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account ?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()));
                                },
                                child: Text("Sign In"),
                              ),
                            ],
                          )
                        ],
                      ),
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
              })),
    );
  }

  void signup() async {
    if (fnameC.text.isNotEmpty &&
        lnameC.text.isNotEmpty &&
        emailC.text.isNotEmpty &&
        passC.text.isNotEmpty &&
        confirmpassC.text.isNotEmpty &&
        enrollNoC.text.isNotEmpty &&
        startingYear.text.isNotEmpty &&
        endingYear.text.isNotEmpty &&
        college != null &&
        branch != null) {
      if (passC.text == confirmpassC.text) {
        if (emailC.text.toLowerCase().endsWith('ipu.ac.in')) {
          if (accept) {
            try {
              UserCredential userCredential = await FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailC.text, password: passC.text);
              int time = DateTime.now().millisecondsSinceEpoch;

              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              String version = packageInfo.version;
              String buildNumber = packageInfo.buildNumber;
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

              IosDeviceInfo iosinfo;
              AndroidDeviceInfo androidinfo;

              if (Platform.isIOS) {
                iosinfo = await deviceInfo.iosInfo;
                await users.doc(userCredential.user!.uid).set({
                  "email": emailC.text,
                  "fname": fnameC.text,
                  "lname": lnameC.text,
                  "enrollNo": enrollNoC.text,
                  "college": college,
                  "branch": branch,
                  "startingYear": DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(startingYear.text)),
                  "endingYear": DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(endingYear.text)),
                  "status": 1,
                  "following": [],
                  "likes": [],
                  "comments": [],
                  "time": time,
                  "lastOpened": time,
                  "platform": "ios",
                  "currentPlatform": "ios",
                  "appVersion": version,
                  "currentappVersion": version,
                  "appBuildNumber": buildNumber,
                  "currentappBuildNumber": buildNumber,
                  "modelName": iosinfo.model,
                  "currentmodelName": iosinfo.model,
                  "deviceName": iosinfo.name,
                  "currentdeviceName": iosinfo.name,
                });
              } else if (Platform.isAndroid) {
                androidinfo = await deviceInfo.androidInfo;
                await users.doc(userCredential.user!.uid).set({
                  "email": emailC.text,
                  "fname": fnameC.text,
                  "lname": lnameC.text,
                  "college": college,
                  "branch": branch,
                  "enrollNo": enrollNoC.text,
                  "startingYear": DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(startingYear.text)),
                  "endingYear": DateFormat('dd-MM-yyyy')
                      .format(DateTime.parse(endingYear.text)),
                  "premium": 0,
                  "status": 1,
                  "time": time,
                  "lastOpened": time,
                  "platform": "android",
                  "currentPlatform": "android",
                  "appVersion": version,
                  "currentappVersion": version,
                  "appBuildNumber": buildNumber,
                  "currentappBuildNumber": buildNumber,
                  "modelName": androidinfo.model,
                  "currentmodelName": androidinfo.model,
                  "deviceName": androidinfo.device,
                  "currentdeviceName": androidinfo.device,
                });
              }

              /*final userData =
              await _database.child('users/${userCredential.user!.uid}').set({
            "email": emailc.text,
            "name": namec.text,
            "lastname": lastnamec.text,
            "premium": 0,
            "status": 1,
            "time": time,
            "lastOpened": time,
            "platform": Platform.isIOS ? "ios" : "android",
            "currentPlatform": Platform.isIOS ? "ios" : "android",
            "appVersion": version,
            "currentappVersion": version,
            "appBuildNumber": buildNumber,
            "currentappBuildNumber": buildNumber,
            "modelName": Platform.isIOS ? iosinfo.model : androidinfo.model,
            "currentmodelName": info.toString()
          });*/
              /* UserDetails user =
              UserDetails(name: namec.text, email: emailc.text, premium: 0);

          CurrentUser.user = user;
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('name', user.name);
          await prefs.setString('email', user.email);*/

              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EmailVerificationPage(
                            email: emailC.text,
                            name: fnameC.text,
                            userCredential: userCredential,
                          )));
              /*  ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Account Created Successfully")));*/
            } on FirebaseAuthException catch (e) {
              if (e.code == 'weak-password') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('The password provided is too weak.'),
                  duration: Duration(seconds: 3),
                ));
              } else if (e.code == 'email-already-in-use') {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('The account already exists for that email.'),
                  duration: Duration(seconds: 3),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(e.code.toString()),
                  duration: Duration(seconds: 3),
                ));
              }
            } catch (e) {
              print(e);
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please Agree the Terms and Conditions to proceed further.'),
              duration: Duration(seconds: 3),
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please Enter Correct GGSIPU Email Address.'),
            duration: Duration(seconds: 3),
          ));
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Password doesn't match")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please fill all the required fields")));
    }
    setState(() {
      //   logging = false;
    });
  }
}
