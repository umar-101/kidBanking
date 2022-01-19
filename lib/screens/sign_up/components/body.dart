import 'package:flutter/material.dart';
import 'package:kidbanking/components/lintText.dart';
import 'package:kidbanking/components/socal_card.dart';

import '../../../size_config.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(
            title: "Sign Up",
            des: "Enter your details below & free sign up",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          const SignForm(),
          SizedBox(height: getProportionateScreenHeight(10)),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(30)),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Already have an account? ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: getProportionateScreenWidth(14)),
                ),
              ),
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          const LineText(
            title: 'Signup with',
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocalCard(
                icon: "assets/images/apple-logo.png",
                press: () {},
              ),
              SocalCard(
                icon: "assets/images/google.png",
                press: () {},
              ),
              SocalCard(
                icon: "assets/images/facebook.png",
                press: () {},
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          // const NoAccountText(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  final String title;
  final String des;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.des,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight * 0.17,
      width: SizeConfig.screenWidth,
      color: const Color(0xFFF0F0F2),
      child: Padding(
        padding: EdgeInsets.only(
            left: getProportionateScreenWidth(20),
            bottom: getProportionateScreenHeight(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: getProportionateScreenWidth(28),
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              des,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
