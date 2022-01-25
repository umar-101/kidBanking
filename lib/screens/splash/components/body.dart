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
        child: Column(
          children: <Widget>[
            SizedBox(height: getProportionateScreenHeight(20)),
            currentPage == 2
                ? Container(
                    height: SizeConfig.screenHeight * 0.10,
                  )
                : SizedBox(
                    height: SizeConfig.screenHeight * 0.10,
                    child: GestureDetector(
                        onTap: () {
                          Session.saveSessionBool("st", true);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: getProportionateScreenWidth(20),
                                  top: getProportionateScreenHeight(35)),
                              child: const Text(
                                'Skip',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))),
                  ),
            Expanded(
              flex: 5,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  title: splashData[index]['title'],
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    const Spacer(flex: 3),
                    currentPage == 2
                        ? Row(
                            children: [
                              DefaultButton(
                                text: "Sign up",
                                press: () {
                                  Session.saveSessionBool("st", true);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                  // Navigator.pushNamed(
                                  //     context, SignUpScreen.routeName);
                                },
                              ),
                              SizedBox(width: getProportionateScreenWidth(20)),
                              DefaultButtonOut(
                                text: 'Log in',
                                press: () {
                                  Session.saveSessionBool("st", true);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUpScreen()));
                                  // Navigator.pushNamed(
                                  //     context, LogInScreen.routeName);
                                },
                              )
                            ],
                          )
                        : Container(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
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
