import 'package:flutter/material.dart';
import 'package:revamph_assignment/screens/login_screen.dart';
import 'package:revamph_assignment/widgets/buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Center(
            child: Text(
              "Welcome Again!",
              style: TextStyle(
                fontSize: 70,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Text(
              "Logged In Successfully.",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Button(
                text: "Sign Out",
                press: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => LoginPage()));
                }),
          )
        ],
      ),
    );
  }
}
