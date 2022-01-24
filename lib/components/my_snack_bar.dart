import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySnackBar extends StatelessWidget {
  const MySnackBar({Key? key, required this.content}) : super(key: key);
  final String content;
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}
