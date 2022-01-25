import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/size_config.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  Body({required this.documentId, Key? key}) : super(key: key);
  final String documentId;
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool check = false;
  Color checkColor = kPrimaryColor;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          right: getProportionateScreenWidth(30),
          left: getProportionateScreenWidth(30),
          bottom: getProportionateScreenWidth(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.17),
            Container(
              width: SizeConfig.screenWidth,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delete Goal',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: getProportionateScreenWidth(22)),
                    ),
                    SizedBox(height: getProportionateScreenHeight(40)),
                    const Text(
                      "Do you want to delete the Goal?",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    Row(
                      children: [
                        Checkbox(
                            side: BorderSide(color: checkColor),
                            value: check,
                            onChanged: (v) {
                              setState(() {
                                check = v!;
                              });
                            }),
                        Text(
                          " I am sure to delete this goal!",
                          style: TextStyle(color: checkColor),
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10)),
                      child: SizedBox(
                        width: SizeConfig.screenWidth,
                        child: DefaultButton(
                          text: "Done",
                          press: () {
                            if (check) {
                              setState(() {
                                checkColor = kPrimaryColor;
                              });
                              Provider.of<KidProvider>(context, listen: false)
                                  .deleteGoal(widget.documentId);
                              Navigator.pop(context);
                            } else {
                              setState(
                                () {
                                  checkColor = Colors.red;
                                },
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: getProportionateScreenWidth(40),
                ))
          ],
        ),
      ),
    );
  }
}
