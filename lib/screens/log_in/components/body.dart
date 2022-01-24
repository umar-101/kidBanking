import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kidbanking/components/lintText.dart';
import 'package:kidbanking/components/no_account_text.dart';
import 'package:kidbanking/components/socal_card.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/screens/home/home.dart';
import 'package:kidbanking/screens/sign_up/components/body.dart';
import 'package:kidbanking/screens/social/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../size_config.dart';
import 'login_form.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
                press: signinWithApple,
              ),
              SocalCard(
                icon: "assets/images/google.png",
                press: () {
                  return MyGoogleSignIn.signInWithGoogle(context: context);
                },
              ),
              SocalCard(
                icon: "assets/images/facebook.png",
                press: signInWithFacebook,
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

  Future<Resource?> signInWithFacebook() async {
    try {
      User? user;
      FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential = await FirebaseAuth.instance
              .signInWithCredential(facebookCredential);
          user = userCredential.user;
          if (user!.emailVerified) {
            Provider.of<UserProvider>(context, listen: false)
                .registerUser(user.email, user.displayName);
            Provider.of<UserProvider>(context, listen: false).loginFinished();
            await Session.saveSession("email", user.email!);
            await Session.saveSession("name", user.displayName!);
            await Provider.of<UserProvider>(context, listen: false)
                .readUserInformation();
            Navigator.pushNamed(context, HomeScreen.routeName);
          }
          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  Future signinWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        // TODO: Set the `clientId` and `redirectUri` arguments to the values you entered in the Apple Developer portal during the setup
        clientId: 'de.lunaone.flutter.signinwithappleexample.service',
        redirectUri:
            // For web your redirect URI needs to be the host of the "current page",
            // while for Android you will be using the API server that redirects back into your app via a deep link
            Uri.parse(
          'https://flutter-sign-in-with-apple-example.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
      // TODO: Remove these if you have no need for them
      nonce: 'example-nonce',
      state: 'example-state',
    );
    // ignore: avoid_print
    print(credential);
    // This is the endpoint that will convert an authorization code obtained
    // via Sign in with Apple into a session in your system
    final signInWithAppleEndpoint = Uri(
      scheme: 'https',
      host: 'flutter-sign-in-with-apple-example.glitch.me',
      path: '/sign_in_with_apple',
      queryParameters: <String, String>{
        'code': credential.authorizationCode,
        if (credential.givenName != null) 'firstName': credential.givenName!,
        if (credential.familyName != null) 'lastName': credential.familyName!,
        'useBundleId': 'false',
        if (credential.state != null) 'state': credential.state!,
      },
    );

    final session = await http.Client().post(
      signInWithAppleEndpoint,
    );

    // If we got this far, a session based on the Apple ID credential has been created in your system,
    // and you can now set this as the app's session
    // ignore: avoid_print
    print(session);
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
}

class Resource {
  final Status status;
  Resource({required this.status});
}

enum Status { Success, Error, Cancelled }
