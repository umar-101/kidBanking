import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kidbanking/providers/kid_provider.dart';
import 'package:kidbanking/providers/user_provider.dart';
import 'package:kidbanking/routes.dart';
import 'package:kidbanking/screens/log_in/login2.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      home: SignInDemo(),
      // const HomeScreen(),
      // const SplashScreen(),
      // We use routeName so that we dont need to remember the name
      // initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
