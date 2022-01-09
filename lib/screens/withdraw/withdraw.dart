import 'package:flutter/material.dart';
import 'package:kidbanking/screens/withdraw/components/body.dart';

import '../../size_config.dart';

class WithDrawScreen extends StatelessWidget {
  static String routeName = "/withdraw_screen";
  const WithDrawScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      backgroundColor: Color(0xFF4C4C61),
      body: Body(),
    );
  }
}
