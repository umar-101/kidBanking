import 'package:flutter/material.dart';

import '../../size_config.dart';
import 'components/body.dart';

class LogInScreen extends StatelessWidget {
  static String routeName = "/login";
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
