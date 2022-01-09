import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(10)),
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      child: DefaultButton(
                        text: "Done",
                        press: () {
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
    );
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

TextFormField buildAmountFormField() {
  return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kEmailNullError);
      //   } else if (emailValidatorRegExp.hasMatch(value)) {
      //     removeError(error: kInvalidEmailError);
      //   }
      //   return;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: buildInputDecoration.copyWith(hintText: '\$ 0'));
}

TextFormField buildReasonFormField() {
  return TextFormField(
      keyboardType: TextInputType.emailAddress,
      // onSaved: (newValue) => email = newValue,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kEmailNullError);
      //   } else if (emailValidatorRegExp.hasMatch(value)) {
      //     removeError(error: kInvalidEmailError);
      //   }
      //   return;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: buildInputDecoration.copyWith(hintText: 'Allowance'));
}
