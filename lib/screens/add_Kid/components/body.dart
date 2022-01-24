import 'package:flutter/material.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/components/form_error.dart';
import 'package:kidbanking/helper/Datepicker.dart';
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

  String msg = "";
  late String selectedDate = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      textfield: InkWell(
                          onTap: () async {
                            DateTime d = await Datepicker.selectDate(context);
                            print(d);
                            DateTime fromDate = d;
                            setState(() {
                              selectedDate = fromDate.toString().split(" ")[0];
                            });
                          },
                          child: buildBirthdayFormField()),
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
                    FormError(errors: errors),
                    Text(
                      msg,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getProportionateScreenWidth(20)),
                      child: SizedBox(
                        width: SizeConfig.screenWidth,
                        child: DefaultButton(
                          text: "Submit",
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              await Provider.of<KidProvider>(context,
                                      listen: false)
                                  .registerKid(
                                      name, username, selectedDate, password)
                                  .then((value) {
                                print(value);
                                setState(() {
                                  name = "";
                                  username = "";
                                  birthday = "";
                                  password = "";
                                  msg = "The Kid have been added Added";
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'The Kid have been added Added!')));
                              }).catchError((error) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Failed to Register your Kid. please retry')));
                                print("Failed to add user: $error");
                                if (error.code == 'weak-password') {
                                  print('The password provided is too weak.');
                                } else if (error.code ==
                                    'email-already-in-use') {
                                  print(
                                      'The account already exists for that email.');
                                }
                              });
                              Navigator.pop(context);
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

// TextEditing
  String? name;
  TextFormField buildNameFormField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => name = newValue,
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
        decoration: buildInputDecoration.copyWith(hintText: 'Aviv'));
  }

  String? birthday;
  TextFormField buildBirthdayFormField() {
    return TextFormField(
        enabled: false,
        // keyboardType: TextInputType.datetime,
        // onSaved: (newValue) => birthday = newValue,
        // onChanged: (value) {
        //   if (value.isNotEmpty) {
        //     removeError(error: kEmailNullError);
        //   }

        //   return;
        // },
        // validator: (value) {
        //   if (value!.isEmpty) {
        //     addError(error: kEmailNullError);
        //     return "";
        //   }

        //   return null;
        // },

        decoration: buildInputDecoration.copyWith(hintText: selectedDate));
  }

  String? username;
  TextFormField buildUsernameFormField() {
    return TextFormField(
        keyboardType: TextInputType.name,
        onSaved: (newValue) => username = newValue,
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
        decoration: buildInputDecoration.copyWith(hintText: 'Aviv2012'));
  }

  String? password;
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
      decoration: buildInputDecoration.copyWith(hintText: '********'),
    );
  }
}

class FormRow extends StatefulWidget {
  final String title;
  final Widget textfield;
  const FormRow({
    Key? key,
    required this.title,
    required this.textfield,
  }) : super(key: key);

  @override
  State<FormRow> createState() => _FormRowState();
}

class _FormRowState extends State<FormRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(70),
          child:
              //  Expanded(
              //   child:
              Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black87,
            ),
            // ),
          ),
        ),
        SizedBox(width: getProportionateScreenWidth(25)),
        Expanded(
            child: Padding(
          padding: EdgeInsets.only(
            right: getProportionateScreenWidth(50),
          ),
          child: SizedBox(
              height: getProportionateScreenHeight(50),
              child: widget.textfield),
        ))
      ],
    );
  }
}
