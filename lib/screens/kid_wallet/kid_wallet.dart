import 'package:flutter/material.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/screens/kid_wallet/components/body.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';

class KidWalletScreen extends StatefulWidget {
  static String routeName = "/kid_wallet_screen";
  const KidWalletScreen({Key? key}) : super(key: key);

  @override
  State<KidWalletScreen> createState() => _KidWalletScreenState();
}

class _KidWalletScreenState extends State<KidWalletScreen> {
  @override
  void initState() {
    super.initState();
    read();
  }

  read() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<KidProvider>(context, listen: false).readKidInformation(
          Provider.of<KidProvider>(context, listen: false).kidUn);
    });
    // Provider.of<KidProvider>(context, listen: false).readGoal();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFFFFE7EE),
      body: SafeArea(child: Body()),
    );
  }
}
