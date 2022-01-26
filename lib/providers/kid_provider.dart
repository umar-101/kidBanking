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

  initPocket() {
    totalInPocket = 0;
    notifyListeners();
  }

  addtotalInPocket(double a, index) {
    if (index == 0) totalInPocket = 0;
    totalInPocket = totalInPocket + a;
    notifyListeners();
  }

  bool _readingKidInformation = false;
  get readingKidInformation => _readingKidInformation;
  readKidInformation(username) async {
    _readingKidInformation = true;
    notifyListeners();
    if (username != null) {
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
          _readingKidInformation = false;
          notifyListeners();
        },
      );
    }
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
        "date_time": DateTime.now(),
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
      readGoal(selectedKid.username);
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
        readKidInformation(selectedKid.username);
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
        readKidInformation(selectedKid.username);
      },
    );
  }

  Future deleteGoal(id) async {
    await FirebaseFirestore.instance
        .collection('goals')
        .doc(id)
        .delete()
        .then((value) {
      readGoal(selectedKid.username);
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

  readGoal(String kidUn) async {
    goals = [];
    notifyListeners();
    await FirebaseFirestore.instance
        .collection('goals')
        .where('username', isEqualTo: kidUn)
        .where("status", isEqualTo: "pending")
        .get()
        .then(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          var doc = snapshot.docs[0];
          goals.add(doc['description']);
          notifyListeners();
        } else {
          goals = [];
          notifyListeners();
        }
      },
    );
  }
}
