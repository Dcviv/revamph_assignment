import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback press;
  const Button({
    required this.text,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.only(
          top: 6,
          bottom: 6,
        ),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.blue),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
