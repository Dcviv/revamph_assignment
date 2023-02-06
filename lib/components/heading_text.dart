import 'package:flutter/material.dart';

import 'credentials.dart';

class HeadingText extends StatelessWidget {
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
              "Login",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Credentials(),
          )
        ],
      ),
    );
  }
}
