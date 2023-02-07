import 'package:flutter/material.dart';
import './home.dart';
import './settings.dart';
import './login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/settings': (context) => SettingsScreen(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}