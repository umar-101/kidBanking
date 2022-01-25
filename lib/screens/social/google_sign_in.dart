import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kidbanking/components/my_snack_bar.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/screens/home/home.dart';
import 'package:provider/provider.dart';

class MyGoogleSignIn {
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    // TODO delete the next line for sessioning
    googleSignIn.signOut();
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        if (user!.emailVerified) {
          Provider.of<UserProvider>(context, listen: false)
              .registerUser(user.email, user.displayName);
          Provider.of<UserProvider>(context, listen: false).loginFinished();
          await Session.saveSession("email", user.email!);
          await Session.saveSession("name", user.displayName!);
          await Provider.of<UserProvider>(context, listen: false)
              .readUserInformation();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));

          // Navigator.pushNamed(context, HomeScreen.routeName);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          const MySnackBar(
            content: 'The account already exists with a different credential.',
          );
        } else if (e.code == 'invalid-credential') {
          const MySnackBar(
            content: 'Error occurred while accessing credentials. Try again.',
          );
        }
      } catch (e) {
        print("--------exceptionnnnn 222222------");

        const MySnackBar(
          content: 'Error occurred using Google Sign-In. Try again.',
        );
        // handle the error here
      }
    }

    return user;
  }

  // static SnackBar customSnackBar({required String content}) {
  //   return SnackBar(
  //     backgroundColor: Colors.black,
  //     content: Text(
  //       content,
  //       style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
  //     ),
  //   );
  // }
}
