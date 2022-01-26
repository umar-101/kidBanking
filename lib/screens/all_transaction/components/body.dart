import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidbanking/components/counting_row.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/models/trans.dart';
import 'package:kidbanking/providers/kid_provider.dart';

import 'package:kidbanking/size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  // final List<Transaction> transactions;
  Body({
    Key? key,
  }) : super(key: key);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                )),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(15),
                  vertical: getProportionateScreenHeight(20)),
              child: Column(
                children: [
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection("kid_transactions")
                          .where("username",
                              isEqualTo: Provider.of<KidProvider>(context,
                                      listen: false)
                                  .selectedKid
                                  .username)
                          .orderBy("date_time", descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              // print(data);
                              return data['amount'].length > 0
                                  ? countingRow(
                                      number: index + 1,
                                      color: data['status'] == "deposit"
                                          ? kPrimaryColor
                                          : Colors.red,
                                      title: data['reason'],
                                      amount: (data['status'] == "deposit"
                                              ? "+ "
                                              : "- ") +
                                          "\$" +
                                          data['amount'].toString(),
                                    )
                                  : const Text("");
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("No Transaction"),
                          );
                        }
                      },
                    ),
                  ),

                  // SizedBox(height: getProportionateScreenHeight(20)),
                  // const CountingRow(
                  //   number: '02',
                  //   title: 'Allowance',
                  //   amount: '+ \$20',
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget countingRow({title, number, amount, color}) {
    print(amount);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      child: SizedBox(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.08,
        child: Row(
          children: [
            Text(
              number.toString(),
              style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: getProportionateScreenWidth(26)),
            ),
            SizedBox(width: getProportionateScreenWidth(30)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(14)),
                ),
                Text(
                  amount,
                  style: TextStyle(
                      color: color, fontSize: getProportionateScreenWidth(14)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
