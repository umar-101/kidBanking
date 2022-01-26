import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidbanking/components/counting_row.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/screens/delete_goal/delete_goal.dart';
import 'package:kidbanking/size_config.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Size screen;
  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size;
    return Container(
      width: screen.width,
      height: screen.height,
      padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(15),
          vertical: getProportionateScreenHeight(25)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: screen.height * 0.3,
            width: screen.width,
            child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection("goals")
                    .where("username",
                        isEqualTo: Provider.of<KidProvider>(context)
                            .selectedKid
                            .username)
                    .where("status", isEqualTo: "pending")
                    .orderBy("datetime", descending: true)
                    .limit(2)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 230,
                      width: 100,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      child: snapshot.data!.docs.isNotEmpty
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                return GoalCard(
                                  documentId: snapshot.data!.docs[index].id,
                                  title: data['description'],
                                  cost: '\$ ' + data['cost'].toString(),
                                  perValue: 0.5,
                                  barColor: Colors.red.shade200,
                                  bgColor: const Color(0xFFFFE7EE),
                                );
                              })
                          : const Center(
                              child: Text("No Pending Goal"),
                            ),
                    );
                  } else {
                    return const Center(child: Text("No Data"));
                  }
                  // return
                }),
          ),

          // Row(
          //   children: [
          //     GoalCard(
          //       title: 'Buy XBox',
          //       cost: '\$ 140',
          //       perValue: 0.5,
          //       barColor: Colors.red.shade200,
          //       bgColor: const Color(0xFFFFE7EE),
          //     ),
          //     SizedBox(width: getProportionateScreenWidth(20)),
          //     GoalCard(
          //       title: 'Pokemon Cards',
          //       cost: '\$ 2.5',
          //       perValue: 1.0,
          //       barColor: kPrimaryColor,
          //       bgColor: Colors.blue.shade100,
          //     ),
          //   ],
          // ),

          SizedBox(height: getProportionateScreenHeight(15)),
          Text(
            'Completed Goals',
            style: TextStyle(
                color: const Color(0xFFFF7C26),
                fontSize: getProportionateScreenWidth(15),
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: getProportionateScreenHeight(15)),
          StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection("goals")
                  .where("username",
                      isEqualTo:
                          Provider.of<KidProvider>(context, listen: false)
                              .selectedKid
                              .username)
                  .where("status", isEqualTo: "completed")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: screen.height * 0.4,
                    // color: Colors.red,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = snapshot.data!.docs[index]
                              .data() as Map<String, dynamic>;
                          print(snapshot.data!.docs[index].id);
                          return CountingRow(
                            number: index + 1,
                            title: data['description'],
                            amount: double.parse(data['cost'].toString()),
                          );
                        }),
                  );
                } else {
                  return const Text("");
                }
                // return
              }),

          //  ListView.builder(
          //   itemCount: goals.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return CountingRow(
          //       number: goals[index].id,
          //       title: goals[index].title,
          //       amount: goals[index].balance,
          //     );
          //   },
          // ),

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
  final String documentId;
  const GoalCard({
    Key? key,
    required this.title,
    required this.cost,
    required this.perValue,
    required this.barColor,
    required this.documentId,
    required this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        // Expanded(
        //   child:
        Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      width: SizeConfig.screenWidth * 0.42,
      height: 50, // SizeConfig.screenHeight * 0.4,
      decoration: kcontDecoration.copyWith(color: bgColor),
      padding: const EdgeInsets.only(bottom: 5, left: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DeleteGoalScreen(documentId: documentId)));

                // if (await confirm(
                //   context,
                //   content: const Text("Do you want to delete this goal?"),
                // )) {
                //   Provider.of<KidProvider>(context, listen: false)
                //       .deleteGoal(documentId);
                // }
              },
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
                Container(
                  padding: const EdgeInsets.only(bottom: 5),
                  // width: SizeConfig.screenWidth * 0.25,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: getProportionateScreenWidth(17),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // Container(
                //   height: 250,
                //   color: Colors.red,
                //   child:
                Row(
                  children: [
                    Text(
                      'Cost',
                      style: TextStyle(color: Colors.grey.shade900),
                    ),
                    // const Spacer(),
                    Text(
                      cost,
                      style: TextStyle(color: Colors.grey.shade900),
                    )
                  ],
                ),
                // ),
                SizedBox(height: getProportionateScreenHeight(5)),
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
                SizedBox(height: getProportionateScreenHeight(5)),
                InkWell(
                  onTap: () {
                    Provider.of<KidProvider>(context, listen: false)
                        .markGoalAsCompleted(documentId)
                        .then((value) {});
                  },
                  child: const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Mark Completed',
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),

      // ),
    );
  }
}
