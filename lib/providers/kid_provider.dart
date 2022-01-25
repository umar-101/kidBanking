import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:kidbanking/models/kid_model.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:intl/intl.dart';

class KidProvider extends ChangeNotifier {
  KidModel? _selectedKid;
  get selectedKid => _selectedKid;
  String? kidUn;
  get getKidUn => kidUn;
  setKidUn(un) {
    kidUn = un;
  }

  double totalInPocket = 0;
  get getTotalInPocket => totalInPocket;
  addtotalInPocket(double a, index) {
    if (index == 0) totalInPocket = 0;
    totalInPocket = totalInPocket + a;
    notifyListeners();
  }

  readKidInformation(username) async {
    await FirebaseFirestore.instance
        .collection('kids')
        .where('username', isEqualTo: username)
        .get()
        .then(
      (snapshot) {
        var doc = snapshot.docs[0];
        Session.saveSession("kid_email", doc['email']);
        Session.saveSession("kid_name", doc['name']);
        Session.saveSession("kid_username", doc['username']);
        _selectedKid = KidModel(
            email: doc['email'],
            username: doc['username'],
            name: doc["name"],
            age: 10,
            balance: double.parse(doc['balance'].toString()),
            image: "assets/images/child.png");
        notifyListeners();
      },
    );
  }

  Future registerKid(name, username, birthdate, password) async {
    CollectionReference kids = FirebaseFirestore.instance.collection('kids');
    await kids.add({
      "email": await Session.readSession("email"),
      'username': username,
      'name': name,
      'balance': 0,
      'birthdate': birthdate,
      "password": password,
    });
  }

  Future writeTransaction(amount, reason, status) async {
    CollectionReference kids =
        FirebaseFirestore.instance.collection('kid_transactions');
    return await kids.add(
      {
        "email": await Session.readSession("email"),
        'username': selectedKid.username,
        'status': status,
        'amount': amount,
        'reason': reason,
        "datetime": DateFormat.yMd().format(DateTime.now())
      },
    );
  }

  Future writeGoals(cost, description) async {
    CollectionReference goals = FirebaseFirestore.instance.collection('goals');
    await goals.add(
      {
        "email": await Session.readSession("email"),
        'username': selectedKid.username,
        'cost': cost,
        "status": "pending",
        'description': description,
        "datetime": DateTime.now()
      },
    ).then((value) {
      print(value);
      readGoal();
      print("The Goal have been added Added");
    }).onError((error, stackTrace) {
      print(stackTrace);
    }).catchError((error) {
      print("Failed to add user: $error");
      if (error.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (error.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    });
  }

  widthdraw(amount) async {
    await FirebaseFirestore.instance
        .collection('kids')
        .where('username', isEqualTo: selectedKid.username)
        .get()
        .then(
      (snapshot) async {
        var doc = snapshot.docs[0];
        double balance = double.parse(doc['balance'].toString());
        balance = balance - double.parse(amount.toString());
        await FirebaseFirestore.instance
            .collection('kids')
            .doc(snapshot.docs[0].id)
            .update({"balance": balance});
      },
    );
  }

  deposit(amount) async {
    await FirebaseFirestore.instance
        .collection('kids')
        .where('username', isEqualTo: selectedKid.username)
        .get()
        .then(
      (snapshot) async {
        var doc = snapshot.docs[0];
        double balance = double.parse(doc['balance'].toString());
        balance = balance + double.parse(amount.toString());
        await FirebaseFirestore.instance
            .collection('kids')
            .doc(snapshot.docs[0].id)
            .update({"balance": balance});
      },
    );
  }

  Future deleteGoal(id) async {
    await FirebaseFirestore.instance
        .collection('goals')
        .doc(id)
        .delete()
        .then((value) {
      readGoal();
    });
  }

  Future markGoalAsCompleted(id) async {
    await FirebaseFirestore.instance
        .collection('goals')
        .doc(id)
        .update({"status": "completed"});
  }

  List<String> goals = [];
  get getGoals => goals;

  readGoal() async {
    print("------------------");
    goals = [];

    notifyListeners();
    await FirebaseFirestore.instance
        .collection('goals')
        .where('username', isEqualTo: selectedKid.username)
        .get()
        .then(
      (snapshot) {
        print("---------++++++++++++---------");
        if (snapshot.docs.isNotEmpty) {
          var doc = snapshot.docs[0];
          goals.add(doc['description']);
          notifyListeners();
        }
      },
    );
  }
}
