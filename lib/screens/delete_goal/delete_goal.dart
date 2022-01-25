import 'package:flutter/material.dart';
import 'package:kidbanking/screens/delete_goal/components/body.dart';

import '../../size_config.dart';

class DeleteGoalScreen extends StatelessWidget {
  static String routeName = "/delete_goal_screen";
  const DeleteGoalScreen({required this.documentId, Key? key})
      : super(key: key);
  final String documentId;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF4C4C61),
      body: Body(documentId: documentId),
    );
  }
}
