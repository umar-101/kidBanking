import 'package:flutter/material.dart';
import 'package:kidbanking/screens/deposit/components/body.dart';

import '../../size_config.dart';

class DepositScreen extends StatelessWidget {
  static String routeName = "/deposit_screen";
  const DepositScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF4C4C61),
      body: Body(),
    );
  }
}
