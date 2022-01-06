import 'package:flutter/material.dart';
import 'package:kidbanking/helper/keyboard.dart';
import 'package:kidbanking/screens/home/home.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool? remember = false;
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
            buildPasswordFormField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            SizedBox(
              width: SizeConfig.screenWidth,
              child: DefaultButton(
                text: "Create Account",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // if all are valid then go to success screen
                    KeyboardUtil.hideKeyboard(context);
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  }
                },
              ),
            ),
            SizedBox(
              height: getProportionateScreenHeight(10),
            ),
            Row(
              children: [
                Checkbox(
                  side: BorderSide(color: Colors.grey.shade400),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value;
                    });
                  },
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: getProportionateScreenHeight(10)),
                  child: Text(
                    "By Creating an account you have to agree\n with our terms & conditios",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: getProportionateScreenWidth(12),
                    ),
                  ),
                ),
                // const Spacer(),
                // GestureDetector(
                //   onTap: () => Navigator.pushNamed(
                //       context, ForgotPasswordScreen.routeName),
                //   child: const Text(
                //     "Forgot Password",
                //     style: TextStyle(decoration: TextDecoration.underline),
                //   ),
                // )
              ],
            ),
            // //  FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(20)),
          ],
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue,
        onChanged: (value) {
          if (value.isNotEmpty) {
            removeError(error: kPassNullError);
          } else if (value.length >= 8) {
            removeError(error: kShortPassError);
          }
          return;
        },
        validator: (value) {
          if (value!.isEmpty) {
            addError(error: kPassNullError);
            return kPassNullError;
          } else if (value.length < 8) {
            addError(error: kShortPassError);
            return kShortPassError;
          }
          return null;
        },
        decoration: buildInputDecoration("Enter your password").copyWith(
            suffixIcon: const Icon(
          Icons.visibility_off_outlined,
          color: Colors.black,
        )));
  }

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
            return kEmailNullError;
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            addError(error: kInvalidEmailError);
            return kInvalidEmailError;
          }
          return null;
        },
        decoration: buildInputDecoration("Enter your email"));
  }

  InputDecoration buildInputDecoration(String title) {
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

class LabelText extends StatelessWidget {
  final String title;
  const LabelText({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
