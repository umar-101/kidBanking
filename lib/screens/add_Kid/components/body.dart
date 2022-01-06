import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/size_config.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(20)),
      child: Column(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.6,
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
                    'Add Kid',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: getProportionateScreenWidth(22)),
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  FormRow(
                    title: 'Name',
                    textfield: buildNameFormField(),
                  ),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  FormRow(
                    title: 'Birthday',
                    textfield: buildBirthdayFormField(),
                  ),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  FormRow(
                    title: 'Username',
                    textfield: buildUsernameFormField(),
                  ),
                  SizedBox(height: getProportionateScreenHeight(8)),
                  FormRow(
                    title: 'Password',
                    textfield: buildPasswordFormField(),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(20)),
                    child: SizedBox(
                      width: SizeConfig.screenWidth,
                      child: DefaultButton(
                        text: "submit",
                        press: () {},
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
        SizedBox(width: getProportionateScreenWidth(25)),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(50),
          ),
          child: SizedBox(
              height: getProportionateScreenHeight(50), child: textfield),
        ))
      ],
    );
  }
}

TextFormField buildNameFormField() {
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
      decoration: buildInputDecoration.copyWith(hintText: 'Aviv'));
}

TextFormField buildBirthdayFormField() {
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
      decoration: buildInputDecoration.copyWith(hintText: 'dd/MM/yyyy'));
}

TextFormField buildUsernameFormField() {
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
      decoration: buildInputDecoration.copyWith(hintText: 'Aviv2012'));
}

TextFormField buildPasswordFormField() {
  return TextFormField(
    // obscureText: true,
    // onSaved: (newValue) => password = newValue,
    // onChanged: (value) {
    //   if (value.isNotEmpty) {
    //     removeError(error: kPassNullError);
    //   } else if (value.length >= 8) {
    //     removeError(error: kShortPassError);
    //   }
    //   password = value;
    // },
    // validator: (value) {
    //   if (value!.isEmpty) {
    //     addError(error: kPassNullError);
    //     return "";
    //   } else if (value.length < 8) {
    //     addError(error: kShortPassError);
    //     return "";
    //   }
    //   return null;
    // },
    decoration: buildInputDecoration.copyWith(hintText: '********'),
  );
}
