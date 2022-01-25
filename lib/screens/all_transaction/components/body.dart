import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kidbanking/components/counting_row.dart';
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
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map<String, dynamic> data =
                                  snapshot.data!.docs[index].data()
                                      as Map<String, dynamic>;
                              return CountingRow(
                                number: index + 1,
                                title: data['reason'],
                                amount: double.parse(data['amount']),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text("No Data"),
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
}
