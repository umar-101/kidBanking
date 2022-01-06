// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../size_config.dart';

class LineText extends StatelessWidget {
  final String title;
  const LineText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(30),
          vertical: getProportionateScreenHeight(15)),
      child: Row(
        children: [
          Expanded(
              child: Container(
            height: 1,
            color: Colors.grey.shade300,
          )),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
            ),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: getProportionateScreenWidth(14)),
            ),
          ),
          Expanded(
              child: Container(
            height: 1,
            color: Colors.grey.shade300,
          )),
        ],
      ),
    );
  }
}
