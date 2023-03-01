import 'package:flutter/material.dart';
import 'package:linkuss/widgets/buttons.dart';
import 'package:linkuss/widgets/textfields.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Align(
                    alignment: Alignment.center,
                    child: primaryTextField(
                        hint: "Username", prefix: Icon(Icons.person)))),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: Align(
                    alignment: Alignment.center,
                    child: primaryTextField(
                        hint: "Enter Password", prefix: Icon(Icons.lock)))),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Align(
                    alignment: Alignment.center,
                    child: primaryButton(MediaQuery.of(context).size.width / 2,
                        callback: () {}, title: "Login"))),
          ],
        ),
      ),
    );
  }
}
