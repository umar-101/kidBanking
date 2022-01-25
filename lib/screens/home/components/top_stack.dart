import 'package:flutter/material.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/screens/log_in/login.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class TopStackContainer extends StatelessWidget {
  const TopStackContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: SizeConfig.screenHeight * 0.33,
          color: Colors.white,
        ),
        Container(
          height: SizeConfig.screenHeight * 0.25,
          color: kPrimaryColor,
          child: Padding(
            padding: EdgeInsets.only(
                left: getProportionateScreenWidth(25),
                right: getProportionateScreenWidth(25),
                bottom: getProportionateScreenHeight(30)),
            child: Row(
              children: [
                Text(
                  // ignore: unnecessary_null_comparison
                  'Hi, '
                      // + Provider.of<UserProvider>(context).userInfo.te
                      +
                      Provider.of<UserProvider>(context)
                          .userInfo
                          .name
                          .toString(),
                  // : "",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(24),
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Provider.of<UserProvider>(context, listen: false).logout();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LogInScreen()));
                  },
                  child: CircleAvatar(
                    radius: getProportionateScreenWidth(20),
                    backgroundImage:
                        const AssetImage('assets/images/personavater.png'),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: SizeConfig.screenHeight * 0.17,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Container(
              width: SizeConfig.screenWidth * 0.88,
              height: SizeConfig.screenHeight * 0.15,
              decoration: kcontDecoration,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(25),
                    vertical: getProportionateScreenHeight(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total amount in kids wallets',
                      style: kSmallHeading,
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$ ' +
                              Provider.of<KidProvider>(context)
                                  .getTotalInPocket
                                  .toString(),
                          style: kSmallHeading.copyWith(color: Colors.black),
                        ),
                        const Spacer(),
                        Text(
                          '% Goal',
                          style: kSmallHeading.copyWith(
                              color: const Color(0xFFFF7C26)),
                        ),
                      ],
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
            ),
          ),
        )
      ],
    );
  }
}
