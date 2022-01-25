import 'package:flutter/material.dart';
import 'package:kidbanking/components/lintText.dart';
import 'package:kidbanking/components/no_account_text.dart';
import 'package:kidbanking/components/socal_card.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:kidbanking/screens/sign_up/components/body.dart';
import 'package:kidbanking/screens/social/apple_login.dart';
import 'package:kidbanking/screens/social/facebook_login.dart';
import 'package:kidbanking/screens/social/google_sign_in.dart';
import '../../../size_config.dart';
import 'login_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Session.saveSessionBool("st", true);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomAppBar(
            title: "Log In",
            des: " ",
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          const LogInForm(),
          SizedBox(height: getProportionateScreenHeight(10)),
          SizedBox(height: SizeConfig.screenHeight * 0.01),
          const NoAccountText(),
          SizedBox(height: getProportionateScreenHeight(10)),
          const LineText(
            title: 'or login with',
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocalCard(
                icon: "assets/images/apple-logo.png",
                press: () {
                  AppleLogin.signinWithApple();
                },
              ),
              SocalCard(
                icon: "assets/images/google.png",
                press: () {
                  return MyGoogleSignIn.signInWithGoogle(context: context);
                },
              ),
              SocalCard(
                icon: "assets/images/facebook.png",
                press: () {
                  MyFacebooklogin.signInWithFacebook(context: context);
                },
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          // const NoAccountText(),
        ],
      ),
    );
  }

  // static Future<User?> signInWithGoogle({required BuildContext context}) async {
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   // TODO delete the next line for sessioning
  //   googleSignIn.signOut();
  //   GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //         await googleSignInAccount.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );

  //     try {
  //       final UserCredential userCredential =
  //           await auth.signInWithCredential(credential);
  //       user = userCredential.user;
  //       if (user!.emailVerified) {
  //         Provider.of<UserProvider>(context, listen: false)
  //             .registerUser(user.email, user.displayName);
  //         Provider.of<UserProvider>(context, listen: false).loginFinished();
  //         await Session.saveSession("email", user.email!);
  //         await Session.saveSession("name", user.displayName!);
  //         await Provider.of<UserProvider>(context, listen: false)
  //             .readUserInformation();
  //         Navigator.pushNamed(context, HomeScreen.routeName);
  //       }
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           customSnackBar(
  //             content:
  //                 'The account already exists with a different credential.',
  //           ),
  //         );
  //       } else if (e.code == 'invalid-credential') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           customSnackBar(
  //             content: 'Error occurred while accessing credentials. Try again.',
  //           ),
  //         );
  //       }
  //     } catch (e) {
  //       print("--------exceptionnnnn 222222------");
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         customSnackBar(
  //           content: 'Error occurred using Google Sign-In. Try again.',
  //         ),
  //       );
  //       // handle the error here
  //     }
  //   }

  //   return user;
  // }

  // Future<Resource?> signInWithFacebook() async {
  //   try {
  //     User? user;
  //     FacebookAuth.instance.logOut();
  //     final LoginResult result = await FacebookAuth.instance.login();
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         final AuthCredential facebookCredential =
  //             FacebookAuthProvider.credential(result.accessToken!.token);
  //         final userCredential = await FirebaseAuth.instance
  //             .signInWithCredential(facebookCredential);
  //         user = userCredential.user;
  //         if (user!.emailVerified) {
  //           Provider.of<UserProvider>(context, listen: false)
  //               .registerUser(user.email, user.displayName);
  //           Provider.of<UserProvider>(context, listen: false).loginFinished();
  //           await Session.saveSession("email", user.email!);
  //           await Session.saveSession("name", user.displayName!);
  //           await Provider.of<UserProvider>(context, listen: false)
  //               .readUserInformation();
  //           Navigator.pushNamed(context, HomeScreen.routeName);
  //         }
  //         return Resource(status: Status.Success);
  //       case LoginStatus.cancelled:
  //         return Resource(status: Status.Cancelled);
  //       case LoginStatus.failed:
  //         return Resource(status: Status.Error);
  //       default:
  //         return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     throw e;
  //   }
  // }

}

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }
