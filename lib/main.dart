import 'package:flutter/material.dart';
import 'package:flutternew/signup.dart';
import 'package:flutternew/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        _navKey.currentState?.pushReplacementNamed('/');
      } else {
        print('User is signed in!');
        _navKey.currentState?.pushReplacementNamed('/third');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navKey,
      title: 'Flutter Developer',
      initialRoute: '/',
      routes: {'/': (context) => const Login(),
        '/second': (context) => const SignUp(),
        '/third' : (context) => const HomePage(),
      });
  }
}
