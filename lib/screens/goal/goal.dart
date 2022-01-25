import 'package:flutter/material.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/screens/add_goal/add_goal.dart';
import 'package:kidbanking/screens/goal/components/body.dart';
import 'package:kidbanking/screens/kid_wallet/kid_wallet.dart';

import '../../size_config.dart';

class GoalScreen extends StatelessWidget {
  static String routeName = "/goal_screen";
  const GoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Goals',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, KidWalletScreen.routeName);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: getProportionateScreenWidth(20),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AddGoalScreen.routeName);
            },
            icon: const Icon(Icons.add),
            color: kPrimaryColor,
          ),
        ],
      ),
      body: Body(),
    );
  }
}
