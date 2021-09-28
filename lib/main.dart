import 'pages/welcome_pg.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(
      ),
    );
  }
}