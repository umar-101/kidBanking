import 'package:flutter/material.dart';
import 'package:kidbanking/models/trans.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/screens/all_transaction/components/body.dart';
import 'package:kidbanking/screens/kid_wallet/kid_wallet.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class AllTransactionScreen extends StatelessWidget {
  static String routeName = "/all_transaction_screen";
  const AllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFE7EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE7EE),
        title: Text(
          Provider.of<KidProvider>(context).selectedKid.name +
              "'s Transactions",
          style: TextStyle(
              color: Colors.black,
              fontSize: getProportionateScreenWidth(20),
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, KidWalletScreen.routeName);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: SafeArea(child: Body()),
    );
  }
}
