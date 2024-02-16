import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:linkuss/pages/login.dart';
import 'package:linkuss/utils/colors.dart';
import '../widgets/buttons.dart';
import '../widgets/textfields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _email;
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _password;
  late final TextEditingController _confirmPassword;
  late final TextEditingController _enrollmentNumber;
  late final TextEditingController _branch;
  late final TextEditingController _college;
  late final TextEditingController _startingYear;
  late final TextEditingController _endingYear;
  @override
  void initState() {
    _email = TextEditingController();
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _password = TextEditingController();
    _confirmPassword = TextEditingController();
    _enrollmentNumber = TextEditingController();
    _branch = TextEditingController();
    _college = TextEditingController();
    _startingYear = TextEditingController();
    _endingYear = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    _enrollmentNumber.dispose();
    _branch.dispose();
    _college.dispose();
    _startingYear.dispose();
    _endingYear.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 249, 248, 253),
      body: SafeArea(
          child: SingleChildScrollView(
        child: FutureBuilder(
          // future: Firebase.initializeApp(
          //   options: DefaultFirebaseOptions.currentPlatform,
          // ),
          builder: (context, snapshot) {
            return Column(
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
                      borderRadius: BorderRadius.circular(20), color: Colors.white),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: primaryTextField(
                                controller: _firstName,
                                hint: "First Name",
                                prefix: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: primaryTextField(
                                controller: _lastName,
                                hint: "Last Name",
                                prefix: Icon(Icons.person),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  controller: _email,
                                  hint: "GGSIPU Email",
                                  prefix: Icon(Icons.mail)))),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  obscureText: true,
                                  controller: _password,
                                  hint: "Password",
                                  prefix: Icon(Icons.lock)))),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  controller: _confirmPassword,
                                  
                                  hint: "Confirm Password",
                                  prefix: Icon(Icons.lock)))),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  controller: _enrollmentNumber,
                                  hint: "Enrollment Number",
                                  prefix: Icon(Icons.book)))),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  controller: _college,
                                  hint: "College",
                                  prefix: Icon(Icons.book)))),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  controller: _branch,
                                  hint: "Branch",
                                  prefix: Icon(Icons.book)))),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  controller: _startingYear,
                                  hint: "Starting Year",
                                  prefix: Icon(Icons.calendar_month_outlined)))),
                      Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Align(
                              alignment: Alignment.center,
                              child: primaryTextField(
                                  controller: _endingYear,
                                  hint: "Ending Year",
                                  prefix: Icon(Icons.calendar_month_outlined)))),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: true,
                      onChanged: (value) {},
                      activeColor: MyColors.primary,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: const Text(
                        "I accept all the above information is correct and any false information may lead to my account suspension.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: primaryButton(MediaQuery.of(context).size.width / 2,
                        callback: () async {
                          // final email = _email.text;
                          // final password = _password.text;
                          // final userCredential = await FirebaseAuth.instance
                          //     .createUserWithEmailAndPassword(
                          //   email: email,
                          //   password: password,
                          // );
                          // print(userCredential);
                        }, title: "Register"),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account ?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const LoginPage()));
                      },
                      child: const Text("Sign In"),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
