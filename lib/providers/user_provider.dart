import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kidbanking/models/user_model.dart';
import 'package:kidbanking/providers/session.dart';

class UserProvider extends ChangeNotifier {
  late UserModel? _userInfo = null;
  get userInfo => _userInfo;
  late bool _readingUserInfo = false;
  get readingUserInfo => _readingUserInfo;

  readUserInfo() async {
    String? email = await Session.readSession("email");
    String? name = await Session.readSession("name");
    _userInfo = UserModel(email!, name!);
  }

  readUserInformation() async {
    _readingUserInfo = true;
    notifyListeners();
    String? email = await Session.readSession("email");
    if (email == null) return;
    await FirebaseFirestore.instance
        .collection('users_informations')
        .where('email', isEqualTo: email)
        .get()
        .then(
      (snapshot) {
        List<DocumentSnapshot> templist;
        templist = snapshot.docs; // <--- ERROR
        _readingUserInfo = false;
        var doc = snapshot.docs[0];
        Session.saveSession("email", doc['email']);
        Session.saveSession("name", doc['name']);
        _userInfo = UserModel(doc['email'], doc["name"]);
        notifyListeners();
      },
    );
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _loggingIn = false;
  get loggingIn => _loggingIn;

  Future login(email, password) async {
    print(email + " " + password);
    _loggingIn = true;
    notifyListeners();
    await auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        return value;
      },
    );

    // .onError((error, stackTrace) async {
    //   _loggingIn = true;
    // return  loginFinished();
    // });
  }

  loginFinished() {
    _loggingIn = false;
    notifyListeners();
  }

  // final nameController = TextEditingController();
  // final emailController = TextEditingController();
  // final password1Controller = TextEditingController();
  // final password2Controller = TextEditingController();
  // final dobController = TextEditingController();

  registerUser(email, name) async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('users_informations');
    // Call the user's CollectionReference to add a new user
    return await users.add({'email': email, 'name': name}).then((value) {
      print(value);
      print("User Added");
    }).catchError((error) {
      print("Failed to add user: $error");
      if (error.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    });
  }

  logout() async {
    Session.cleanAll();
    notifyListeners();
  }

  bool _loggedIn = false;
  get loggedIn => _loggedIn;
  isUserLoggedIn() {
    Session.isKeyAvailable("email").then((value) {
      _loggedIn = value;
      notifyListeners();
    });
  }
}
