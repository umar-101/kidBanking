import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/components/form_error.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/size_config.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  String msg = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
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
                height: SizeConfig.screenHeight * 0.45,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20),
                    vertical: getProportionateScreenHeight(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Deposit',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: getProportionateScreenWidth(22)),
                      ),
                      SizedBox(height: getProportionateScreenHeight(40)),
                      FormRow(
                        title: 'Amount',
                        textfield: buildAmountFormField(),
                      ),
                      SizedBox(height: getProportionateScreenHeight(8)),
                      FormRow(
                        title: 'Reason',
                        textfield: buildReasonFormField(),
                      ),
                      const Spacer(),
                      FormError(errors: errors),
                      Text(
                        msg,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(10)),
                        child: SizedBox(
                          width: SizeConfig.screenWidth,
                          child: DefaultButton(
                            text: "Done",
                            press: () {
                              if (reasonController.text.length < 2) {
                                addError(error: "Please write the reason");
                                return;
                              }
                              if (amountController.text.isNotEmpty) {
                                if (double.parse(amountController.text) > 0) {
                                  Provider.of<KidProvider>(context,
                                          listen: false)
                                      .deposit(amountController.text);
                                  Provider.of<KidProvider>(context,
                                          listen: false)
                                      .writeTransaction(amountController.text,
                                          reasonController.text, "deposit")
                                      .then((value) {
                                    Provider.of<KidProvider>(context,
                                            listen: false)
                                        .readKidInformation(
                                            Provider.of<KidProvider>(context,
                                                    listen: false)
                                                .selectedKid
                                                .username);

                                    setState(() {
                                      amountController.text = '';
                                      reasonController.text = '';
                                      msg = "Transaction Done";
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text('Transaction Done!',
                                                style: TextStyle(
                                                    color: Colors.blue))));
                                  }).onError((error, stackTrace) {
                                    print(stackTrace);
                                  });
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Amount have to be greater than \$0!')));
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please Enter the amount of money!')));
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
      ),
    );
  }

  final List<String?> errors = [];

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  double? amount;
  TextEditingController amountController = TextEditingController();
  TextFormField buildAmountFormField() {
    return TextFormField(
        controller: amountController,
        keyboardType: TextInputType.number,
        onSaved: (newValue) => amount = double.tryParse(newValue!),
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          }
          return null;
        },
        decoration: buildInputDecoration.copyWith(hintText: '\$ 0'));
  }

  String? reason;
  TextEditingController reasonController = TextEditingController();

  TextFormField buildReasonFormField() {
    return TextFormField(
        controller: reasonController,
        keyboardType: TextInputType.multiline,
        onSaved: (newValue) => reason = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          }
          return null;
        },
        decoration: buildInputDecoration.copyWith(hintText: 'Allowance'));
  }
}

class FormRow extends StatelessWidget {
  final String title;
  final Widget textfield;
  const FormRow({
    Key? key,
    required this.title,
    required this.textfield,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(70),
          child:
              // Expanded(
              //   child:
              Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
          // ),
        ),
        SizedBox(width: getProportionateScreenWidth(20)),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(10),
          ),
          child: SizedBox(
              height: getProportionateScreenHeight(50), child: textfield),
        ))
      ],
    );
  }
}
