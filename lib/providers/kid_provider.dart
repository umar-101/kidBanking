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

  readKidInformation(username) async {
    await FirebaseFirestore.instance
        .collection('kids')
        .where('username', isEqualTo: username)
        .get()
        .then(
      (snapshot) {
        List<DocumentSnapshot> templist = snapshot.docs; // <--- ERROR
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
    return await kids.add({
      "email": await Session.readSession("email"),
      'username': username,
      'name': name,
      'balance': 0,
      'birthdate': birthdate,
      "password": password
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

  Future writeGoals(username, cost, description) async {
    CollectionReference goals = FirebaseFirestore.instance.collection('goals');
    return await goals.add(
      {
        "email": await Session.readSession("email"),
        'username': username,
        'cost': cost,
        "status": "pending",
        'description': description,
        "datetime": DateFormat.yMd().format(DateTime.now())
      },
    );
  }

  // Future widthdraw() {}

  // Future deposit() {}
}
