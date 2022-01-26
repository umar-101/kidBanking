import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kidbanking/components/lintText.dart';
import 'package:kidbanking/components/no_account_text.dart';
import 'package:kidbanking/components/socal_card.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:kidbanking/screens/sign_up/components/body.dart';
import 'package:kidbanking/screens/social/apple_login.dart';
import 'package:kidbanking/screens/social/facebook_login.dart';
import 'package:kidbanking/screens/social/google_sign_in.dart';
import '../../../size_config.dart';
import 'login_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
    Session.saveSessionBool("st", true);
  }

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
              if (!Platform.isAndroid)
                SocalCard(
                  icon: "assets/images/apple-logo.png",
                  press: () {
                    AppleLogin.signinWithApple();
                  },
                ),
              SocalCard(
                icon: "assets/images/google.png",
                press: () {
                  return MyGoogleSignIn.signInWithGoogle(context: context);
                },
              ),
              SocalCard(
                icon: "assets/images/facebook.png",
                press: () {
                  MyFacebooklogin.signInWithFacebook(context: context);
                },
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
        ],
      ),
    );
  }
}

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }
