import 'package:flutter/material.dart';
import 'package:kidbanking/components/counting_row.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/models/goal.dart';
import 'package:kidbanking/size_config.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Body extends StatelessWidget {
  final List<Goal> goals;
  const Body({Key? key, required this.goals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GoalCard(
                title: 'Buy XBox',
                cost: '\$ 140',
                perValue: 0.5,
                barColor: Colors.red.shade200,
                bgColor: const Color(0xFFFFE7EE),
              ),
              SizedBox(width: getProportionateScreenWidth(20)),
              GoalCard(
                title: 'Pokemon Cards',
                cost: '\$ 2.5',
                perValue: 1.0,
                barColor: kPrimaryColor,
                bgColor: Colors.blue.shade100,
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          Text(
            'Completed Goals',
            style: TextStyle(
                color: const Color(0xFFFF7C26),
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (BuildContext context, int index) {
                  return CountingRow(
                    number: goals[index].id,
                    title: goals[index].title,
                    amount: goals[index].balance,
                  );
                },
              ),
            ),
          )

          // SizedBox(height: getProportionateScreenHeight(20)),
          // const CountingRow(
          //   number: '02',
          //   title: 'Cards',
          //   amount: '+ \$20',
          // ),
        ],
      ),
    );
  }
}

class GoalCard extends StatelessWidget {
  final String title, cost;
  final Color barColor, bgColor;
  final double perValue;
  const GoalCard({
    Key? key,
    required this.title,
    required this.cost,
    required this.perValue,
    required this.barColor,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: SizeConfig.screenHeight * 0.30,
        decoration: kcontDecoration.copyWith(color: bgColor),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.cancel),
                  color: Colors.grey,
                  iconSize: getProportionateScreenWidth(20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: SizeConfig.screenWidth * 0.25,
                      height: SizeConfig.screenHeight * 0.07,
                      child: Text(
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: getProportionateScreenWidth(17),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          'Cost',
                          style: TextStyle(color: Colors.grey.shade900),
                        ),
                        const Spacer(),
                        Text(
                          cost,
                          style: TextStyle(color: Colors.grey.shade900),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    LinearPercentIndicator(
                      // width: SizeConfig.screenWidth * 0.35,
                      lineHeight: 7,
                      percent: perValue,
                      backgroundColor: Colors.white54,
                      progressColor: barColor,
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Text(
                      '80%',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    const Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Mark Completed',
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
