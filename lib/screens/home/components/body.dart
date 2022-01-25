import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kidbanking/constants.dart';
import 'package:kidbanking/models/kid.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/screens/add_Kid/add_kid.dart';
import 'package:kidbanking/screens/home/components/top_stack.dart';
import 'package:kidbanking/screens/kid_wallet/kid_wallet.dart';
import 'package:kidbanking/size_config.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopStackContainer(),
        const AddChild(),
        KidDetails(
          kids: kids,
        )
      ],
    );
  }
}

class KidDetails extends StatefulWidget {
  final List<Kid> kids;
  KidDetails({
    Key? key,
    required this.kids,
  }) : super(key: key);

  @override
  State<KidDetails> createState() => _KidDetailsState();
}

class _KidDetailsState extends State<KidDetails> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  double totalInPocket = 0;
  calculateAge(String bd) {
    DateTime birthDate = DateTime.parse(bd);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection("kids")
              .where("email",
                  isEqualTo: Provider.of<UserProvider>(context).userInfo.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    WidgetsBinding.instance?.addPostFrameCallback((_) =>
                        Provider.of<KidProvider>(context, listen: false)
                            .addtotalInPocket(
                                double.parse(data['balance'].toString()),
                                index));

                    return Padding(
                      padding: EdgeInsets.only(
                        left: getProportionateScreenWidth(20),
                        right: getProportionateScreenWidth(20),
                        bottom: getProportionateScreenWidth(10),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<KidProvider>(context, listen: false)
                              .setKidUn(data['username']);
                          Provider.of<KidProvider>(context, listen: false)
                              .readKidInformation(data['username']);
                          Provider.of<KidProvider>(context, listen: false)
                              .readGoal(data['username']);
                          // Navigator.pushNamed(
                          //     context, KidWalletScreen.routeName);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const KidWalletScreen()));
                        },
                        child: Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight * 0.15,
                          decoration: kcontDecoration,
                          child: Padding(
                            padding:
                                EdgeInsets.all(getProportionateScreenWidth(10)),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: SizeConfig.screenHeight,
                                  width: getProportionateScreenWidth(70),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image(
                                      image:
                                          AssetImage(widget.kids[index].image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: getProportionateScreenWidth(20),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['name'],
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                              getProportionateScreenWidth(15)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.grey.shade400,
                                          size: getProportionateScreenWidth(18),
                                        ),
                                        Text(
                                          'Age:  ' +
                                              calculateAge(data['birthdate'])
                                                  .toString(),
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      ' \$ ${data["balance"]}',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontSize:
                                              getProportionateScreenWidth(18),
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
                  });
            } else {
              return const Text("");
            }
            // return
          }),

      // ListView.builder(
      //   scrollDirection: Axis.vertical,
      //   itemCount: kids.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return
      //     Padding(
      //       padding: EdgeInsets.only(
      //         left: getProportionateScreenWidth(20),
      //         right: getProportionateScreenWidth(20),
      //         bottom: getProportionateScreenWidth(10),
      //       ),
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.pushNamed(context, KidWalletScreen.routeName);
      //         },
      //         child: Container(
      //           width: SizeConfig.screenWidth,
      //           height: SizeConfig.screenHeight * 0.15,
      //           decoration: kcontDecoration,
      //           child: Padding(
      //             padding: EdgeInsets.all(getProportionateScreenWidth(10)),
      //             child: Row(
      //               children: [
      //                 SizedBox(
      //                   height: SizeConfig.screenHeight,
      //                   width: getProportionateScreenWidth(70),
      //                   child: ClipRRect(
      //                     borderRadius: BorderRadius.circular(10),
      //                     child: Image(
      //                       image: AssetImage(kids[index].image),
      //                       fit: BoxFit.cover,
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   width: getProportionateScreenWidth(20),
      //                 ),
      //                 Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       kids[index].name,
      //                       style: TextStyle(
      //                           color: Colors.black,
      //                           fontSize: getProportionateScreenWidth(15)),
      //                     ),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.start,
      //                       children: [
      //                         Icon(
      //                           Icons.person,
      //                           color: Colors.grey.shade400,
      //                           size: getProportionateScreenWidth(18),
      //                         ),
      //                         Text(
      //                           'Age ${kids[index].age}',
      //                           style: TextStyle(
      //                             color: Colors.grey.shade400,
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                     Text(
      //                       ' \$ ${kids[index].balance}',
      //                       style: TextStyle(
      //                           color: kPrimaryColor,
      //                           fontSize: getProportionateScreenWidth(18),
      //                           fontWeight: FontWeight.bold),
      //                     )
      //                   ],
      //                 )
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
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
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, KidWalletScreen.routeName);
            },
            child: Text(
              'Kids',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(16)),
            ),
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
