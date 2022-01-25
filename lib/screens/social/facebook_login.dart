import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:kidbanking/components/my_snack_bar.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/screens/home/home.dart';
import 'package:kidbanking/screens/log_in/components/body.dart';
import 'package:provider/provider.dart';

class MyFacebooklogin {
  static Future<Resource?> signInWithFacebook(
      {required BuildContext context}) async {
    try {
      // print("++++++++++++++++++++++++++++++++++");
      User? user;
      FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();
      // print(result.status);
      // print(result.message);
      // print(result.accessToken);
      // print("-----------------------");
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookCredential);
          user = userCredential.user;
          print(user);
          print(user!.emailVerified);
          // if (user!.emailVerified) {
          Provider.of<UserProvider>(context, listen: false)
              .registerUser(user.email, user.displayName);
          Provider.of<UserProvider>(context, listen: false).loginFinished();
          await Session.saveSession("email", user.email!);
          await Session.saveSession("name", user.displayName!);
          await Provider.of<UserProvider>(context, listen: false)
              .readUserInformation();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
          // }
          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Request Canceled!')));

          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Login Failed. retry!')));
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      const MySnackBar(
        content: 'Error occurred using Google Sign-In. Try again.',
      );
    }
  }
}
