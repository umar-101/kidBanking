import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/components/form_error.dart';
import 'package:kidbanking/screens/sign_up/components/sign_form.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  // ignore: non_constant_identifier_names
  String? conform_password;
  bool remember = false;
  bool obsText = true;
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

  @override
  Widget build(BuildContext context) {
    @override
    showLoginSuccessDialog(BuildContext context) {
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: SizedBox(
          height: SizeConfig.screenHeight * 0.42,
          width: SizeConfig.screenWidth,
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(10)),
              Image.asset(
                "assets/images/success.png",
                height: SizeConfig.screenHeight * 0.1, //40%
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Success",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(17),
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              Text(
                "Account created successfully, we\nhave sent you an activation mail,\nplease follow instructions on that\nmail.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(14),
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: SizeConfig.screenWidth,
                child: DefaultButton(
                  text: "Done",
                  press: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      );

      // show the dialog
      showDialog(
        barrierColor: const Color(0xFF797988),
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Form(
      key: _formKey,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          children: [
            const LabelText(
              title: "Your Email",
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            buildEmailFormField(),
            SizedBox(height: getProportionateScreenHeight(20)),
            const LabelText(
              title: "Password",
            ),
            SizedBox(height: getProportionateScreenHeight(5)),
            TextFormField(
                obscureText: obsText,
                onSaved: (newValue) => password = newValue,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    removeError(error: kPassNullError);
                  } else if (value.length >= 8) {
                    removeError(error: kShortPassError);
                  }
                  password = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    addError(error: kPassNullError);
                    return "";
                  } else if (value.length < 8) {
                    addError(error: kShortPassError);
                    return "";
                  }
                  return null;
                },
                decoration:
                    buildInputDecoration("Enter your password").copyWith(
                        suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      obsText = false;
                    });
                  },
                  icon: const Icon(
                    Icons.visibility_off_outlined,
                  ),
                  color: Colors.black,
                ))),
            SizedBox(height: getProportionateScreenHeight(20)),
            FormError(errors: errors),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                "Forget password? ",
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: getProportionateScreenWidth(14)),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: DefaultButton(
                text: "Log In",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    showLoginSuccessDialog(context);
                    // if all are valid then go to success screen
                    //  Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TextFormField buildPasswordFormField() {
  //   return
  // }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kEmailNullError);
          } else if (emailValidatorRegExp.hasMatch(value)) {
            removeError(error: kInvalidEmailError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kEmailNullError);
            return "";
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return "";
          }
          return null;
        },
        decoration: buildInputDecoration("Enter your email"));
  }

  buildInputDecoration(String title) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      hintText: title,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
      ),
    );
  }
}
