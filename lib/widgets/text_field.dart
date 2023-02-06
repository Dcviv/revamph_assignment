import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 208, 212, 214),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
