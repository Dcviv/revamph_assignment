import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../screens/home_screen.dart';
import '../screens/registration_screen.dart';
import '../sevices/account_check.dart';
import '../widgets/buttons.dart';
import '../widgets/iput_field.dart';

class Credentials extends StatefulWidget {
  @override
  State<Credentials> createState() => _CredentialsState();
}

class _CredentialsState extends State<Credentials> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _emailTextEditingController =
      TextEditingController(text: "");

  TextEditingController _passTextEditingController =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          InputField(
              hintText: "Enter email",
              icon: Icons.email_rounded,
              obsecureText: false,
              textEditingController: _emailTextEditingController),
          InputField(
            hintText: "Enter Password",
            icon: Icons.lock,
            obsecureText: true,
            textEditingController: _passTextEditingController,
          ),
          SizedBox(
            height: 15,
          ),
          Button(
            text: "LOGIN",
            press: () async {
              try {
                await _auth.signInWithEmailAndPassword(
                    email: _emailTextEditingController.text.trim(),
                    password: _passTextEditingController.text.trim());
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => HomeScreen()));
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
            },
          ),
          SizedBox(
            height: 5,
          ),
          AccountCheck(
              login: true,
              press: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => RegistrationPage()));
              })
        ],
      ),
    );
  }
}
