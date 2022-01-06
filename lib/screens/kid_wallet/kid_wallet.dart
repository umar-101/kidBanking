import 'package:flutter/material.dart';
import 'package:kidbanking/models/trans.dart';
import 'package:kidbanking/screens/kid_wallet/components/body.dart';

import '../../size_config.dart';

class KidWalletScreen extends StatelessWidget {
  static String routeName = "/kid_wallet_screen";
  const KidWalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFFFE7EE),
      body: SafeArea(
          child: Body(
        transactions: transactions,
      )),
    );
  }
}
