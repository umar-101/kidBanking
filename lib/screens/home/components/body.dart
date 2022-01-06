import 'package:flutter/material.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/models/kid.dart';
import 'package:kidbanking/screens/add_Kid/add_kid.dart';
import 'package:kidbanking/screens/home/components/top_stack.dart';
import 'package:kidbanking/screens/kid_wallet/kid_wallet.dart';
import 'package:kidbanking/size_config.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopStackContainer(),
        AddChild(),
        KidDetails(
          kids: kids,
        )
      ],
    );
  }
}

class KidDetails extends StatelessWidget {
  final List<Kid> kids;
  const KidDetails({
    Key? key,
    required this.kids,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: kids.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenHeight(10)),
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.15,
              decoration: kcontDecoration,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, KidWalletScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                  child: Row(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight,
                        width: getProportionateScreenWidth(70),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            image: AssetImage(kids[index].image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getProportionateScreenWidth(20),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kids[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: getProportionateScreenWidth(15)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.grey.shade400,
                                size: getProportionateScreenWidth(18),
                              ),
                              Text(
                                'Age ${kids[index].age}',
                                style: TextStyle(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            ' \$ ${kids[index].balance}',
                            style: TextStyle(
                                color: kPrimaryColor,
                                fontSize: getProportionateScreenWidth(18),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddChild extends StatelessWidget {
  const AddChild({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        children: [
          Text(
            'Kids',
            style: TextStyle(
                color: Colors.black, fontSize: getProportionateScreenWidth(16)),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddKidScreen.routeName);
              },
              icon: Icon(
                Icons.add,
                color: kPrimaryColor,
                size: getProportionateScreenWidth(18),
              ))
        ],
      ),
    );
  }
}
