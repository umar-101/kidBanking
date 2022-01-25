import 'package:flutter/widgets.dart';
import 'package:kidbanking/screens/add_Kid/add_kid.dart';
import 'package:kidbanking/screens/add_goal/add_goal.dart';
import 'package:kidbanking/screens/all_transaction/all_transaction.dart';
import 'package:kidbanking/screens/delete_goal/delete_goal.dart';
import 'package:kidbanking/screens/deposit/deposit.dart';
import 'package:kidbanking/screens/goal/goal.dart';
import 'package:kidbanking/screens/home/home.dart';
import 'package:kidbanking/screens/kid_wallet/kid_wallet.dart';
import 'package:kidbanking/screens/log_in/login.dart';
import 'package:kidbanking/screens/sign_up/sign_up_screen.dart';
import 'package:kidbanking/screens/withdraw/withdraw.dart';

import 'screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
//  LoginSuccessScreen.routeName: (context) => const LoginSuccessScreen(),
  LogInScreen.routeName: (context) => const LogInScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  KidWalletScreen.routeName: (context) => const KidWalletScreen(),
  AddKidScreen.routeName: (context) => const AddKidScreen(),
  WithDrawScreen.routeName: (context) => const WithDrawScreen(),
  DepositScreen.routeName: (context) => const DepositScreen(),
  AddGoalScreen.routeName: (context) => const AddGoalScreen(),

  GoalScreen.routeName: (context) => const GoalScreen(),
  AllTransactionScreen.routeName: (context) => const AllTransactionScreen(),
};
