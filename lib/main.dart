import 'package:flutter/material.dart';
import 'package:kidbanking/routes.dart';
import 'package:kidbanking/screens/add_Kid/add_kid.dart';

import 'package:kidbanking/screens/add_goal/add_goal.dart';
import 'package:kidbanking/screens/all_transaction/all_transaction.dart';
import 'package:kidbanking/screens/deposit/deposit.dart';
import 'package:kidbanking/screens/goal/goal.dart';
import 'package:kidbanking/screens/home/home.dart';
import 'package:kidbanking/screens/log_in/login.dart';
import 'package:kidbanking/screens/login_success/login_success_screen.dart';
import 'package:kidbanking/screens/sign_up/sign_up_screen.dart';
import 'package:kidbanking/screens/splash/splash_screen.dart';
import 'package:kidbanking/screens/withdraw/withdraw.dart';

import 'package:kidbanking/theme.dart';

import 'screens/kid_wallet/kid_wallet.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: const SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
