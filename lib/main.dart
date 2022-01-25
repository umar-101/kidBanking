import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/providers/session.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/routes.dart';
import 'package:kidbanking/screens/home/home.dart';
import 'package:kidbanking/screens/log_in/login.dart';
import 'package:kidbanking/screens/splash/splash_screen.dart';
import 'package:kidbanking/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => KidProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Widget firstRoute = const SplashScreen();

  @override
  void initState() {
    read();
    super.initState();
  }

  bool reading = true;
  bool userLoggedIn = false;
  read() {
    Session.isKeyAvailable("email").then((value) {
      if (value) {
        userLoggedIn = true;
        Provider.of<UserProvider>(context, listen: false).readUserInfo();
      }
      setState(() {
        reading = false;
      });
    });
    Session.isKeyAvailable("st").then((value) {
      if (value == true) {
        firstRoute = const LogInScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'kid Banking',
      theme: theme(),
      home: reading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ChangeNotifierProvider(
              create: (context) => UserProvider(),
              child: userLoggedIn ? const HomeScreen() : firstRoute),
      //  const AppleLogin(),
      // SignInDemo(),
      // const HomeScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
