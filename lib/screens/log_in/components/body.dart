import 'package:flutter/material.dart';
import 'package:kidbanking/components/lintText.dart';
import 'package:kidbanking/components/no_account_text.dart';
import 'package:kidbanking/components/socal_card.dart';
import 'package:kidbanking/screens/sign_up/components/body.dart';

import '../../../size_config.dart';
import 'login_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(
            title: "Log In",
            des: " ",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          const LogInForm(),
          SizedBox(height: getProportionateScreenHeight(10)),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          const NoAccountText(),
          SizedBox(height: getProportionateScreenHeight(10)),
          const LineText(
            title: 'or login with',
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
