import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kidbanking/providers/kid_provider.dart';
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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<KidProvider>(context, listen: false).initPocket();
      Provider.of<UserProvider>(context, listen: false).readUserInfo();
    });
  }

  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return WillPopScope(
      child: Scaffold(
        body: Provider.of<UserProvider>(context).readingUserInfo
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : const Body(),
      ),
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          final snack = const SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false; // false will do nothing when back press
        } else {
          print("+++++");
          exit(0);
          // Navigator.pop(context);
          return true; // true will exit the app
        }
      },
    );

    // Scaffold(
    //   body: Provider.of<UserProvider>(context).readingUserInfo
    //       ? const Center(
    //           child: CircularProgressIndicator(),
    //         )
    //       : const Body(),
    // );
  }

  static const snackBarDuration = Duration(seconds: 3);

  final snackBar = const SnackBar(
    content: Text('Press back again to leave'),
    duration: snackBarDuration,
  );

  late DateTime backButtonPressTime;

  Future<bool> handleWillPop(BuildContext context) async {
    print("------------");
    Navigator.pop(context);
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        now.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }
}
