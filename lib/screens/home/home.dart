import 'package:flutter/material.dart';
import 'package:kidbanking/screens/home/components/body.dart';

import '../../size_config.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
