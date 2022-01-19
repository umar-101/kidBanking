import 'package:flutter/material.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/screens/home/components/body.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home_screen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    read();
  }

  read() {
    Provider.of<UserProvider>(context, listen: false).readUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      body: Body(),
    );
  }
}
