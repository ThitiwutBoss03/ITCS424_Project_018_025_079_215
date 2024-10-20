import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide VoidCallback;
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

// Set defual page as Login Page
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginApp(),
    );
  }
}
