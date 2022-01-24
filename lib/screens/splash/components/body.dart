import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button_outline.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:kidbanking/screens/log_in/login.dart';
import 'package:kidbanking/screens/login_success/login_success_screen.dart';
import 'package:kidbanking/screens/sign_up/sign_up_screen.dart';

// This is the best practice
import '../../../constants.dart';
import '../../../size_config.dart';
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "title": "Quick signup with a\nParent account",
      "text":
          "Parent account gives you\nthe tools to add kids and\nmanage their wallets",
      "image": "assets/images/splash_1.png"
    },
    {
      "title": "Easily add kids\n accounts",
      "text":
          "Privacy matters!\n The kids accounts use vary \nbasic details about your presions ones",
      "image": "assets/images/splash_2.png"
    },
    {
      "title": "Lets begin  ?\n Log in or Sign up\n now.",
      "text": "                                                   ",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : const Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
