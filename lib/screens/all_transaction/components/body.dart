import 'package:flutter/material.dart';
import 'package:kidbanking/components/counting_row.dart';
import 'package:kidbanking/models/trans.dart';

import 'package:kidbanking/size_config.dart';

class Body extends StatelessWidget {
  final List<Transaction> transactions;
  const Body({Key? key, required this.transactions}) : super(key: key);

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
                    child: ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CountingRow(
                          number: transactions[index].id,
                          title: transactions[index].title,
                          amount: transactions[index].balance,
                        );
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
