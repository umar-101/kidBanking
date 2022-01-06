import 'package:flutter/material.dart';
import 'package:kidbanking/constants.dart';

import '../size_config.dart';

class CountingRow extends StatelessWidget {
  final int number;
  final String title;
  final double amount;
  const CountingRow({
    Key? key,
    required this.number,
    required this.title,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.08,
        child: Row(
          children: [
            Text(
              number.toString(),
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: getProportionateScreenWidth(26)),
            ),
            SizedBox(width: getProportionateScreenWidth(30)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(14)),
                ),
                Text(
                  "\$ ${amount}".toString(),
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: getProportionateScreenWidth(14)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
