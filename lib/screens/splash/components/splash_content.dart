import 'package:flutter/material.dart';

import '../../../size_config.dart';

class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    this.text,
    this.image,
    this.title,
  }) : super(key: key);
  final String? text, image, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image.asset(
          image!,
          height: getProportionateScreenHeight(250),
          width: getProportionateScreenWidth(250),
        ),
        SizedBox(height: getProportionateScreenHeight(15)),
        Text(
          title!,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(20),
            color: Colors.black,
            height: 1.5,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(80),
              vertical: getProportionateScreenHeight(15)),
          child: Text(
            text!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              height: 1.4,
              fontSize: getProportionateScreenWidth(15),
            ),
          ),
        ),
      ],
    );
  }
}
