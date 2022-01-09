import 'package:flutter/material.dart';
import 'package:kidbanking/routes.dart';
import 'package:kidbanking/screens/add_Kid/add_kid.dart';
import 'package:kidbanking/screens/deposit/deposit.dart';
import 'package:kidbanking/screens/goal/goal.dart';
import 'package:kidbanking/screens/kid_wallet/kid_wallet.dart';

import 'package:kidbanking/screens/splash/splash_screen.dart';
import 'package:kidbanking/screens/withdraw/withdraw.dart';

import 'package:kidbanking/theme.dart';

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
