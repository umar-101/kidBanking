import 'package:flutter/material.dart';
import 'package:kidbanking/screens/add_goal/components/body.dart';

import '../../size_config.dart';

class AddGoalScreen extends StatelessWidget {
  static String routeName = "/add_goal_screen";
  const AddGoalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: Color(0xFF4C4C61),
      body: Body(),
    );
  }
}
