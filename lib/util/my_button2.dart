import 'package:flutter/material.dart';

class MyButton2 extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButton2({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Text(text),
    );
  }
}