import 'package:flutter/material.dart';
import 'package:kidbanking/components/counting_row.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/models/trans.dart';
import 'package:kidbanking/screens/all_transaction/all_transaction.dart';
import 'package:kidbanking/screens/deposit/deposit.dart';
import 'package:kidbanking/screens/goal/goal.dart';
import 'package:kidbanking/screens/withdraw/withdraw.dart';
import 'package:kidbanking/size_config.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Body extends StatelessWidget {
  final List<Transaction> transactions;
  const Body({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopAppContainer(),
        Expanded(
          child: SingleChildScrollView(
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
                    Row(
                      children: [
                        Text(
                          'Goals',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(20),
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        GoalScreen()));
                          },
                          child: Text(
                            'More',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: getProportionateScreenWidth(16)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.06,
                      child: Column(
                        children: [
                          Text(
                            'Buy XBox',
                            style: TextStyle(
                                color: const Color(0xFFA843DB),
                                fontWeight: FontWeight.w600,
                                fontSize: getProportionateScreenWidth(17)),
                          ),
                          Expanded(
                            child: LinearPercentIndicator(
                              lineHeight: 7,
                              percent: 0.5,
                              backgroundColor: Colors.grey.shade200,
                              progressColor: const Color(0xFFFF7C26),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Row(
                      children: [
                        Text(
                          'Total Amount in Wallet',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: getProportionateScreenWidth(21),
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          '\$550.00',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontSize: getProportionateScreenWidth(21),
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    Align(
                      alignment: Alignment.topLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AllTransactionScreen.routeName);
                        },
                        child: Text(
                          'Last Transactions',
                          style: TextStyle(
                              color: const Color(0xFFFF7C26),
                              fontSize: getProportionateScreenWidth(15),
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(15)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AllTransactionScreen.routeName);
                      },
                      child: Container(
                        height: SizeConfig.screenHeight * 0.30,
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
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.15,
          decoration: kcontDecoration.copyWith(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(15)),
            child: Row(
              children: [
                DefaultButton(
                  text: 'Withdraw',
                  press: () {
                    Navigator.pushNamed(context, WithDrawScreen.routeName);
                  },
                ),
                SizedBox(width: getProportionateScreenWidth(30)),
                DefaultButton(
                  text: 'Deposit',
                  press: () {
                    Navigator.pushNamed(context, DepositScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TopAppContainer extends StatelessWidget {
  const TopAppContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(20),
      ),
      child: SizedBox(
        height: SizeConfig.screenHeight * 0.27,
        width: SizeConfig.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.arrow_back_ios),
            const Spacer(),
            Row(
              children: [
                SizedBox(
                  width: getProportionateScreenWidth(80),
                  child: Column(
                    children: [
                      SizedBox(
                        width: getProportionateScreenWidth(80),
                        height: getProportionateScreenHeight(90),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const Image(
                            image: AssetImage('assets/images/child.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: getProportionateScreenHeight(15)),
                      Text(
                        "Aviv's\nWallet",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(22)),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: const Image(
                      image: AssetImage('assets/images/person-speaker.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
