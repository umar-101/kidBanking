import 'package:flutter/material.dart';
import 'package:kidbanking/screens/add_Kid/components/body.dart';

import '../../size_config.dart';

class AddKidScreen extends StatelessWidget {
  static String routeName = "/addKid_screen";
  const AddKidScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF4C4C61),
      body: Body(),
    );
  }
}
