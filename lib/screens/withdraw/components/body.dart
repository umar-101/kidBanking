import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/components/form_error.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/size_config.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
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
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Withdraw',
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
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(10)),
                      child: SizedBox(
                        width: SizeConfig.screenWidth,
                        child: DefaultButton(
                          text: "Done",
                          press: () {
                            Provider.of<KidProvider>(context, listen: false)
                                .writeTransaction(amountController.text,
                                    reasonController.text, "withdraw")
                                .then((value) {})
                                .onError((error, stackTrace) {
                              print(stackTrace);
                            });
                            Navigator.pop(context);
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
        keyboardType: TextInputType.emailAddress,
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
        keyboardType: TextInputType.emailAddress,
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
        decoration: buildInputDecoration.copyWith(hintText: 'Buy Something'));
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
          child: Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
              ),
            ),
          ),
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
