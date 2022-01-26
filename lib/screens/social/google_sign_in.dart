import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kidbanking/components/default_button.dart';
import 'package:kidbanking/components/my_snack_bar.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/size_config.dart';
import 'package:provider/provider.dart';

class MyGoogleSignIn {
  static TextEditingController nameController = TextEditingController();
  static showLoginSuccessDialog(BuildContext context) {
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
            // Image.asset(
            //   "assets/images/success.png",
            //   height: SizeConfig.screenHeight * 0.1, //40%
            // ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Text(
              "Validate your Name!",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(17),
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(25)),
            TextField(
              controller: nameController,
            ),

            // Text(
            //   "Account created successfully, we\nhave sent you an activation mail,\nplease follow instructions on that\nmail.",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: getProportionateScreenWidth(14),
            //     color: Colors.grey,
            //   ),
            // ),
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
          print(user);
          Provider.of<UserProvider>(context, listen: false)
              .isUserInformationStored(user.email)
              .then((value) {
            print(value.docs);
            print(value.docs.length);
            if (value.docs.isEmpty) {
              print("in if ");
              nameController.text = user!.displayName!;
              return showLoginSuccessDialog(context);
            } else {}
          });
          // Provider.of<UserProvider>(context, listen: false)
          //     .registerUser(user.email, user.displayName);
          // Provider.of<UserProvider>(context, listen: false).loginFinished();
          // await Session.saveSession("email", user.email!);
          // await Session.saveSession("name", user.displayName!);
          // await Provider.of<UserProvider>(context, listen: false)
          //     .readUserInformation();
          // Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) => const HomeScreen()));
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
